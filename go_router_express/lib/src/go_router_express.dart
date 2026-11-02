import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:go_router_express/src/widget_middleware.dart';
import 'package:go_router_express/src/widget_request.dart';
import 'package:go_router_express/src/widget_response.dart';

/// Type definition for a route handler function.
typedef RouteHandler = void Function(WidgetRequest req, WidgetResponse res);

/// Decides whether a request may reach its route.
///
/// Return `null` to let the request through, or a location to redirect to.
/// Guards run before the page is built (backed by go_router's `redirect`),
/// so a rejected page is never shown, not even for a frame.
/// A guard may also return a [Future] for asynchronous checks.
///
/// ```dart
/// app.guard((req) => auth.isSignedIn ? null : '/login');
/// ```
typedef RouteGuard = FutureOr<String?> Function(WidgetRequest req);

// --- Route tree nodes (internal) ---

sealed class _RouteNode {}

class _LeafRoute extends _RouteNode {
  _LeafRoute({
    required this.path,
    required this.handler,
    this.middlewares = const [],
    this.guards = const [],
    this.name,
  });

  final String path;
  final RouteHandler handler;
  final List<WidgetMiddleware> middlewares;
  final List<RouteGuard> guards;
  final String? name;
}

class _GroupNode extends _RouteNode {
  _GroupNode({required this.prefix, required this.group});

  final String prefix;
  final RouteGroup group;
}

class _ShellNode extends _RouteNode {
  _ShellNode({
    required this.builder,
    required this.group,
    this.middlewares = const [],
    this.guards = const [],
  });

  final Widget Function(BuildContext, GoRouterState, Widget) builder;
  final RouteGroup group;
  final List<WidgetMiddleware> middlewares;
  final List<RouteGuard> guards;
}

class _RedirectRoute extends _RouteNode {
  _RedirectRoute({required this.from, required this.to});

  final String from;
  final String to;
}

/// A group of routes that share a common configuration.
///
/// Use this to organize routes with shared prefixes, middleware,
/// or shell layouts.
class RouteGroup {
  final List<_RouteNode> _nodes = [];
  final List<WidgetMiddleware> _middlewares = [];
  final List<RouteGuard> _guards = [];

  bool _sealed = false;

  void _assertNotSealed() {
    if (_sealed) {
      throw StateError(
        'Cannot modify routes after the router has been built. '
        'Register all routes before accessing .router.',
      );
    }
  }

  /// Adds middleware that applies to all routes in this group.
  ///
  /// ```dart
  /// app.use([LoggingMiddleware(), AuthMiddleware()]);
  /// ```
  void use(List<WidgetMiddleware> middlewares) {
    _assertNotSealed();
    _middlewares.addAll(middlewares);
  }

  /// Adds a [RouteGuard] that runs for all routes in this group,
  /// including routes in nested groups and shells.
  ///
  /// Guards run in the order they apply: the outer group's guards first,
  /// then this group's, then the route's own `guards`. The first guard that
  /// returns a location wins.
  ///
  /// ```dart
  /// app.group('/admin', (admin) {
  ///   admin.guard((req) => auth.isAdmin ? null : '/login');
  ///   admin.get('/dashboard', (req, res) => res.page(const Dashboard()));
  /// });
  /// ```
  ///
  /// A guard added to the whole app also runs for the page it redirects to,
  /// so let that page through to avoid a redirect loop:
  ///
  /// ```dart
  /// app.guard((req) {
  ///   if (req.path == '/login') return null;
  ///   return auth.isSignedIn ? null : '/login';
  /// });
  /// ```
  void guard(RouteGuard guard) {
    _assertNotSealed();
    _guards.add(guard);
  }

  /// Registers a route with the given [path] and [handler].
  ///
  /// The [path] can include path parameters using colon notation
  /// (e.g., `/users/:id`).
  ///
  /// ```dart
  /// app.get('/users/:id', (req, res) {
  ///   final id = req.params('id');
  ///   res.page(UserPage(id: id!));
  /// });
  /// ```
  ///
  /// [guards] run before the page is built and can redirect elsewhere.
  /// See [guard].
  void get(
    String path,
    RouteHandler handler, {
    List<WidgetMiddleware> middlewares = const [],
    List<RouteGuard> guards = const [],
    String? name,
  }) {
    _assertNotSealed();
    _nodes.add(
      _LeafRoute(
        path: path,
        handler: handler,
        middlewares: middlewares,
        guards: guards,
        name: name,
      ),
    );
  }

  /// Creates a route group with a shared path [prefix].
  ///
  /// All routes registered inside the [setup] callback will have
  /// their paths prefixed with [prefix].
  ///
  /// ```dart
  /// app.group('/api', (api) {
  ///   api.get('/users', handler);   // matches /api/users
  ///   api.get('/posts', handler);   // matches /api/posts
  /// });
  /// ```
  void group(String prefix, void Function(RouteGroup group) setup) {
    _assertNotSealed();
    final group = RouteGroup();
    setup(group);
    _nodes.add(_GroupNode(prefix: prefix, group: group));
  }

  /// Creates a shell route with a shared layout.
  ///
  /// The [builder] provides the shell layout that wraps all child routes.
  /// Routes registered inside the [setup] callback share this layout.
  ///
  /// ```dart
  /// app.shell(
  ///   (context, state, child) => Scaffold(
  ///     appBar: AppBar(title: const Text('App')),
  ///     body: child,
  ///   ),
  ///   (shell) {
  ///     shell.get('/home', (req, res) => res.page(const HomePage()));
  ///     shell.get('/settings', (req, res) => res.page(const SettingsPage()));
  ///   },
  /// );
  /// ```
  void shell(
    Widget Function(BuildContext context, GoRouterState state, Widget child)
    builder,
    void Function(RouteGroup shell) setup, {
    List<WidgetMiddleware> middlewares = const [],
    List<RouteGuard> guards = const [],
  }) {
    _assertNotSealed();
    final shell = RouteGroup();
    setup(shell);
    _nodes.add(
      _ShellNode(
        builder: builder,
        group: shell,
        middlewares: middlewares,
        guards: guards,
      ),
    );
  }

  /// Registers a redirect from one path to another.
  ///
  /// ```dart
  /// app.redirect('/old-page', '/new-page');
  /// ```
  void redirect(String from, String to) {
    _assertNotSealed();
    _nodes.add(_RedirectRoute(from: from, to: to));
  }
}

/// An Express.js-like wrapper for go_router.
///
/// Provides a familiar Express.js-style API for defining routes
/// in Flutter applications using go_router.
///
/// ```dart
/// final app = GoRouterExpress();
///
/// app.get('/', (req, res) {
///   res.page(const HomePage());
/// });
///
/// app.get('/users/:id', (req, res) {
///   final id = req.params('id');
///   res.page(UserPage(id: id!));
/// });
///
/// runApp(MaterialApp.router(routerConfig: app.router));
/// ```
class GoRouterExpress extends RouteGroup {
  /// Creates a new [GoRouterExpress] instance.
  GoRouterExpress({
    this.initialLocation = '/',
    this.debugLogDiagnostics = false,
    this.errorBuilder,
    this.refreshListenable,
  });

  /// The initial route location.
  final String initialLocation;

  /// Whether to log router diagnostics.
  final bool debugLogDiagnostics;

  /// Custom error page builder.
  final Widget Function(BuildContext, GoRouterState)? errorBuilder;

  /// Re-runs the guards for the current location whenever it notifies.
  ///
  /// Pass the object that holds your sign-in state, so that signing out
  /// moves the user off guarded pages right away.
  final Listenable? refreshListenable;

  GoRouter? _router;

  /// The underlying [GoRouter] instance.
  ///
  /// The router is built lazily on first access.
  /// Pass this to [MaterialApp.router]:
  /// ```dart
  /// MaterialApp.router(routerConfig: app.router)
  /// ```
  GoRouter get router => _router ??= _buildRouter();

  GoRouter _buildRouter() {
    _sealed = true;
    final routes = _buildRouteList(_nodes, _middlewares, _guards, '');
    return GoRouter(
      routes: routes,
      initialLocation: initialLocation,
      debugLogDiagnostics: debugLogDiagnostics,
      refreshListenable: refreshListenable,
      errorBuilder:
          errorBuilder ??
          (context, state) =>
              Center(child: Text('Page not found: ${state.uri.path}')),
    );
  }
}

// --- Route tree → GoRouter routes ---

List<RouteBase> _buildRouteList(
  List<_RouteNode> nodes,
  List<WidgetMiddleware> inheritedMiddlewares,
  List<RouteGuard> inheritedGuards,
  String pathPrefix,
) {
  final routes = <RouteBase>[];

  for (final node in nodes) {
    switch (node) {
      case _LeafRoute():
        final allMiddlewares = [...inheritedMiddlewares, ...node.middlewares];
        final fullPath = '$pathPrefix${node.path}';
        routes.add(
          _buildGoRoute(
            path: fullPath,
            handler: node.handler,
            middlewares: allMiddlewares,
            guards: [...inheritedGuards, ...node.guards],
            name: node.name,
          ),
        );

      case _GroupNode():
        final groupMiddlewares = [
          ...inheritedMiddlewares,
          ...node.group._middlewares,
        ];
        final groupGuards = [...inheritedGuards, ...node.group._guards];
        final newPrefix = '$pathPrefix${node.prefix}';
        routes.addAll(
          _buildRouteList(
            node.group._nodes,
            groupMiddlewares,
            groupGuards,
            newPrefix,
          ),
        );

      case _ShellNode():
        final shellMiddlewares = [
          ...inheritedMiddlewares,
          ...node.middlewares,
          ...node.group._middlewares,
        ];
        final shellGuards = [
          ...inheritedGuards,
          ...node.guards,
          ...node.group._guards,
        ];
        final children = _buildRouteList(
          node.group._nodes,
          shellMiddlewares,
          shellGuards,
          pathPrefix,
        );
        routes.add(ShellRoute(builder: node.builder, routes: children));

      case _RedirectRoute():
        final fullPath = '$pathPrefix${node.from}';
        routes.add(GoRoute(path: fullPath, redirect: (_, _) => node.to));
    }
  }

  return routes;
}

GoRoute _buildGoRoute({
  required String path,
  required RouteHandler handler,
  required List<WidgetMiddleware> middlewares,
  required List<RouteGuard> guards,
  String? name,
}) {
  return GoRoute(
    path: path,
    name: name,
    redirect: guards.isEmpty
        ? null
        : (context, state) =>
              _runGuards(guards, WidgetRequest(context: context, state: state)),
    builder: (context, state) {
      final req = WidgetRequest(context: context, state: state);
      final res = WidgetResponse();

      Widget resultWidget;
      if (middlewares.isEmpty) {
        handler(req, res);
        resultWidget = res.responseWidget ?? const SizedBox.shrink();
      } else {
        final chain = MiddlewareChain(
          middlewares: middlewares,
          finalHandler: (req, res) {
            handler(req, res);
            return res.responseWidget ?? const SizedBox.shrink();
          },
        );
        resultWidget = chain.execute(req, res);
      }

      // Handle redirect (works with both middleware and handler redirects)
      if (res.redirectLocation != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            GoRouter.of(context).go(res.redirectLocation!);
          }
        });
        return const SizedBox.shrink();
      }

      return resultWidget;
    },
  );
}

/// Runs [guards] in order and returns the first redirect location.
///
/// Stays synchronous while the guards are, so go_router can resolve the
/// route without waiting for a frame.
FutureOr<String?> _runGuards(
  List<RouteGuard> guards,
  WidgetRequest req, [
  int start = 0,
]) {
  for (var i = start; i < guards.length; i++) {
    final result = guards[i](req);
    if (result is Future<String?>) {
      return result.then<String?>(
        (location) => location ?? _runGuards(guards, req, i + 1),
      );
    }
    if (result != null) return result;
  }
  return null;
}
