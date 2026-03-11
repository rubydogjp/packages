import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router_express/go_router_express.dart';

void main() {
  group('GoRouterExpress', () {
    testWidgets('renders widget from simple route', (tester) async {
      final app = GoRouterExpress(initialLocation: '/home');
      app.get('/home', (req, res) {
        res.page(const Text('Home Page'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('handles path parameters', (tester) async {
      final app = GoRouterExpress(initialLocation: '/users/123');
      app.get('/users/:id', (req, res) {
        final id = req.params('id');
        res.page(Text('User ID: $id'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('User ID: 123'), findsOneWidget);
    });

    testWidgets('handles query parameters', (tester) async {
      final app = GoRouterExpress(initialLocation: '/search?q=flutter');
      app.get('/search', (req, res) {
        final query = req.query('q');
        res.page(Text('Search: $query'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Search: flutter'), findsOneWidget);
    });

    testWidgets('handles multiple path parameters', (tester) async {
      final app = GoRouterExpress(
        initialLocation: '/users/123/posts/456',
      );
      app.get('/users/:userId/posts/:postId', (req, res) {
        final userId = req.params('userId');
        final postId = req.params('postId');
        res.page(Text('User: $userId, Post: $postId'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('User: 123, Post: 456'), findsOneWidget);
    });

    testWidgets('shows error page for non-existent route', (tester) async {
      final app = GoRouterExpress(initialLocation: '/not-found');
      app.get('/home', (req, res) {
        res.page(const Text('Home Page'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.textContaining('Page not found'), findsOneWidget);
    });

    testWidgets('uses custom error builder', (tester) async {
      final app = GoRouterExpress(
        initialLocation: '/not-found',
        errorBuilder: (context, state) => const Text('Custom 404'),
      );
      app.get('/home', (req, res) {
        res.page(const Text('Home Page'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Custom 404'), findsOneWidget);
    });

    testWidgets('supports named routes', (tester) async {
      final app = GoRouterExpress(initialLocation: '/users/42');
      app.get('/users/:id', (req, res) {
        res.page(Text('User ${req.params("id")}'));
      }, name: 'user');

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('User 42'), findsOneWidget);
    });
  });

  group('RouteGroup', () {
    testWidgets('group prefixes child routes', (tester) async {
      final app = GoRouterExpress(initialLocation: '/api/users');
      app.group('/api', (api) {
        api.get('/users', (req, res) {
          res.page(const Text('API Users'));
        });
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('API Users'), findsOneWidget);
    });

    testWidgets('nested groups combine prefixes', (tester) async {
      final app = GoRouterExpress(initialLocation: '/api/v1/users');
      app.group('/api', (api) {
        api.group('/v1', (v1) {
          v1.get('/users', (req, res) {
            res.page(const Text('API v1 Users'));
          });
        });
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('API v1 Users'), findsOneWidget);
    });

    testWidgets('group middleware applies to all child routes', (
      tester,
    ) async {
      final executionOrder = <String>[];

      final app = GoRouterExpress(initialLocation: '/api/data');
      app.group('/api', (api) {
        api.use([
          _TestMiddleware((req, res, next) {
            executionOrder.add('group-middleware');
            return next();
          }),
        ]);
        api.get('/data', (req, res) {
          executionOrder.add('handler');
          res.page(const Text('Data'));
        });
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(executionOrder, ['group-middleware', 'handler']);
    });
  });

  group('Shell routes', () {
    testWidgets('wraps child routes with shell layout', (tester) async {
      final app = GoRouterExpress(initialLocation: '/dashboard');
      app.shell(
        (context, state, child) => Column(
          children: [const Text('Shell Header'), Expanded(child: child)],
        ),
        (shell) {
          shell.get('/dashboard', (req, res) {
            res.page(const Text('Dashboard Content'));
          });
        },
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Shell Header'), findsOneWidget);
      expect(find.text('Dashboard Content'), findsOneWidget);
    });
  });

  group('Global middleware', () {
    testWidgets('app.use applies middleware to all routes', (tester) async {
      final executionOrder = <String>[];

      final app = GoRouterExpress(initialLocation: '/page');
      app.use([
        _TestMiddleware((req, res, next) {
          executionOrder.add('global');
          return next();
        }),
      ]);
      app.get('/page', (req, res) {
        executionOrder.add('handler');
        res.page(const Text('Page'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(executionOrder, ['global', 'handler']);
    });

    testWidgets('global middleware runs before route middleware', (
      tester,
    ) async {
      final executionOrder = <String>[];

      final app = GoRouterExpress(initialLocation: '/page');
      app.use([
        _TestMiddleware((req, res, next) {
          executionOrder.add('global');
          return next();
        }),
      ]);
      app.get('/page', (req, res) {
        executionOrder.add('handler');
        res.page(const Text('Page'));
      }, middlewares: [
        _TestMiddleware((req, res, next) {
          executionOrder.add('route');
          return next();
        }),
      ]);

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(executionOrder, ['global', 'route', 'handler']);
    });
  });

  group('Redirect', () {
    testWidgets('app.redirect redirects to target path', (tester) async {
      final app = GoRouterExpress(initialLocation: '/old');
      app.redirect('/old', '/new');
      app.get('/new', (req, res) {
        res.page(const Text('New Page'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('New Page'), findsOneWidget);
    });

    testWidgets('res.redirect works without middleware', (tester) async {
      final app = GoRouterExpress(initialLocation: '/gate');
      app.get('/gate', (req, res) {
        res.redirect('/target');
      });
      app.get('/target', (req, res) {
        res.page(const Text('Target'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Target'), findsOneWidget);
    });

    testWidgets('res.redirect works with middleware', (tester) async {
      final app = GoRouterExpress(initialLocation: '/protected');
      app.get('/protected', (req, res) {
        res.redirect('/login');
      }, middlewares: [
        _TestMiddleware((req, res, next) => next()),
      ]);
      app.get('/login', (req, res) {
        res.page(const Text('Login Page'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Login Page'), findsOneWidget);
    });
  });

  group('WidgetRequest', () {
    testWidgets('accesses all path parameters', (tester) async {
      final app = GoRouterExpress(
        initialLocation: '/users/123/posts/456',
      );
      app.get('/users/:userId/posts/:postId', (req, res) {
        final params = req.pathParams;
        expect(params['userId'], '123');
        expect(params['postId'], '456');
        res.page(const Text('OK'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();
    });

    testWidgets('accesses all query parameters', (tester) async {
      final app = GoRouterExpress(
        initialLocation: '/search?q=flutter&sort=date',
      );
      app.get('/search', (req, res) {
        final params = req.queryParams;
        expect(params['q'], 'flutter');
        expect(params['sort'], 'date');
        res.page(const Text('OK'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();
    });

    testWidgets('returns null for non-existent parameter', (tester) async {
      final app = GoRouterExpress(initialLocation: '/users/123');
      app.get('/users/:id', (req, res) {
        expect(req.params('nonexistent'), isNull);
        expect(req.query('nonexistent'), isNull);
        res.page(const Text('OK'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();
    });

    testWidgets('intParam parses integer path parameter', (tester) async {
      final app = GoRouterExpress(initialLocation: '/users/42');
      app.get('/users/:id', (req, res) {
        expect(req.intParam('id'), 42);
        expect(req.intParam('nonexistent'), isNull);
        res.page(const Text('OK'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();
    });

    testWidgets('doubleParam parses double path parameter', (tester) async {
      final app = GoRouterExpress(initialLocation: '/price/19.99');
      app.get('/price/:amount', (req, res) {
        expect(req.doubleParam('amount'), 19.99);
        res.page(const Text('OK'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();
    });

    testWidgets('intQuery parses integer query parameter', (tester) async {
      final app = GoRouterExpress(initialLocation: '/list?page=3&limit=20');
      app.get('/list', (req, res) {
        expect(req.intQuery('page'), 3);
        expect(req.intQuery('limit'), 20);
        expect(req.intQuery('nonexistent'), isNull);
        res.page(const Text('OK'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();
    });

    testWidgets('boolQuery parses boolean query parameter', (tester) async {
      final app = GoRouterExpress(
        initialLocation: '/filter?active=true&verified=1&old=false',
      );
      app.get('/filter', (req, res) {
        expect(req.boolQuery('active'), true);
        expect(req.boolQuery('verified'), true);
        expect(req.boolQuery('old'), false);
        expect(req.boolQuery('nonexistent'), isNull);
        res.page(const Text('OK'));
      });

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();
    });
  });

  group('WidgetResponse', () {
    test('throws when setting response twice', () {
      final res = WidgetResponse();
      res.page(const Text('First'));
      expect(() => res.page(const Text('Second')), throwsA(isA<StateError>()));
    });

    test('throws when setting redirect after widget', () {
      final res = WidgetResponse();
      res.page(const Text('Widget'));
      expect(() => res.redirect('/home'), throwsA(isA<StateError>()));
    });

    test('throws when setting widget after redirect', () {
      final res = WidgetResponse();
      res.redirect('/home');
      expect(() => res.page(const Text('Widget')), throwsA(isA<StateError>()));
    });

    test('tracks response state correctly', () {
      final res = WidgetResponse();
      expect(res.hasResponse, false);
      expect(res.responseWidget, isNull);
      expect(res.redirectLocation, isNull);

      res.page(const Text('Test'));
      expect(res.hasResponse, true);
      expect(res.responseWidget, isA<Text>());
      expect(res.redirectLocation, isNull);
    });

    test('tracks redirect state correctly', () {
      final res = WidgetResponse();
      expect(res.hasResponse, false);

      res.redirect('/home');
      expect(res.hasResponse, true);
      expect(res.responseWidget, isNull);
      expect(res.redirectLocation, '/home');
    });
  });

  group('WidgetMiddleware', () {
    testWidgets('executes middleware before handler', (tester) async {
      final executionOrder = <String>[];

      final app = GoRouterExpress(initialLocation: '/protected');
      app.get('/protected', (req, res) {
        executionOrder.add('handler');
        res.page(const Text('Protected Page'));
      }, middlewares: [
        _TestMiddleware((req, res, next) {
          executionOrder.add('middleware');
          return next();
        }),
      ]);

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(executionOrder, ['middleware', 'handler']);
    });

    testWidgets('allows middleware to return widget directly', (tester) async {
      final app = GoRouterExpress(initialLocation: '/protected');
      app.get('/protected', (req, res) {
        res.page(const Text('Protected Page'));
      }, middlewares: [
        _TestMiddleware((req, res, next) {
          final token = req.query('token');
          if (token != 'valid') {
            return const Text('Unauthorized');
          }
          return next();
        }),
      ]);

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Unauthorized'), findsOneWidget);
      expect(find.text('Protected Page'), findsNothing);
    });

    testWidgets('allows middleware to pass through to handler', (
      tester,
    ) async {
      final app = GoRouterExpress(
        initialLocation: '/protected?token=valid',
      );
      app.get('/protected', (req, res) {
        res.page(const Text('Protected Page'));
      }, middlewares: [
        _TestMiddleware((req, res, next) {
          final token = req.query('token');
          if (token != 'valid') {
            return const Text('Unauthorized');
          }
          return next();
        }),
      ]);

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(find.text('Protected Page'), findsOneWidget);
      expect(find.text('Unauthorized'), findsNothing);
    });

    testWidgets('executes multiple middleware in order', (tester) async {
      final executionOrder = <String>[];

      final app = GoRouterExpress(initialLocation: '/api');
      app.get('/api', (req, res) {
        executionOrder.add('handler');
        res.page(const Text('API Response'));
      }, middlewares: [
        _TestMiddleware((req, res, next) {
          executionOrder.add('middleware1');
          return next();
        }),
        _TestMiddleware((req, res, next) {
          executionOrder.add('middleware2');
          return next();
        }),
        _TestMiddleware((req, res, next) {
          executionOrder.add('middleware3');
          return next();
        }),
      ]);

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(executionOrder, [
        'middleware1',
        'middleware2',
        'middleware3',
        'handler',
      ]);
    });

    testWidgets('stops execution if middleware does not call next', (
      tester,
    ) async {
      final executionOrder = <String>[];

      final app = GoRouterExpress(initialLocation: '/api');
      app.get('/api', (req, res) {
        executionOrder.add('handler');
        res.page(const Text('API Response'));
      }, middlewares: [
        _TestMiddleware((req, res, next) {
          executionOrder.add('middleware1');
          return next();
        }),
        _TestMiddleware((req, res, next) {
          executionOrder.add('blocking');
          return const Text('Blocked');
        }),
        _TestMiddleware((req, res, next) {
          executionOrder.add('middleware3');
          return next();
        }),
      ]);

      await tester.pumpWidget(MaterialApp.router(routerConfig: app.router));
      await tester.pumpAndSettle();

      expect(executionOrder, ['middleware1', 'blocking']);
      expect(find.text('Blocked'), findsOneWidget);
    });
  });
}

class _TestMiddleware extends WidgetMiddleware {
  _TestMiddleware(this.builder);

  final Widget Function(
    WidgetRequest req,
    WidgetResponse res,
    Widget Function() next,
  ) builder;

  @override
  Widget build(
    WidgetRequest req,
    WidgetResponse res,
    Widget Function() next,
  ) {
    return builder(req, res, next);
  }
}
