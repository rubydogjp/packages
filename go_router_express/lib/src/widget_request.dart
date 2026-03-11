import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Represents an incoming request in the go_router_express framework.
///
/// This class wraps the [BuildContext] and [GoRouterState] to provide
/// Express.js-like access to route parameters, query parameters, and other
/// request information.
class WidgetRequest {
  /// Creates a new [WidgetRequest] instance.
  WidgetRequest({required this.context, required this.state});

  /// The [BuildContext] associated with this request.
  final BuildContext context;

  /// The [GoRouterState] containing route information.
  final GoRouterState state;

  // --- Path parameters ---

  /// Returns the value of a path parameter by [name].
  ///
  /// For example, with a route `/users/:id`, calling `params('id')`
  /// will return the id value from the path.
  ///
  /// Returns `null` if the parameter does not exist.
  String? params(String name) => state.pathParameters[name];

  /// Returns all path parameters as a map.
  Map<String, String> get pathParams => state.pathParameters;

  /// Returns a path parameter parsed as an [int], or `null` if
  /// the parameter does not exist or cannot be parsed.
  int? intParam(String name) {
    final value = state.pathParameters[name];
    return value != null ? int.tryParse(value) : null;
  }

  /// Returns a path parameter parsed as a [double], or `null` if
  /// the parameter does not exist or cannot be parsed.
  double? doubleParam(String name) {
    final value = state.pathParameters[name];
    return value != null ? double.tryParse(value) : null;
  }

  // --- Query parameters ---

  /// Returns the value of a query parameter by [name].
  ///
  /// For example, with a URL `/users?sort=name`, calling `query('sort')`
  /// will return `'name'`.
  ///
  /// Returns `null` if the query parameter does not exist.
  String? query(String name) => state.uri.queryParameters[name];

  /// Returns all query parameters as a map.
  Map<String, String> get queryParams => state.uri.queryParameters;

  /// Returns a query parameter parsed as an [int], or `null` if
  /// the parameter does not exist or cannot be parsed.
  int? intQuery(String name) {
    final value = state.uri.queryParameters[name];
    return value != null ? int.tryParse(value) : null;
  }

  /// Returns a query parameter parsed as a [double], or `null` if
  /// the parameter does not exist or cannot be parsed.
  double? doubleQuery(String name) {
    final value = state.uri.queryParameters[name];
    return value != null ? double.tryParse(value) : null;
  }

  /// Returns a query parameter parsed as a [bool], or `null` if
  /// the parameter does not exist.
  ///
  /// The values `'true'` and `'1'` are treated as `true`.
  /// All other values are treated as `false`.
  bool? boolQuery(String name) {
    final value = state.uri.queryParameters[name];
    if (value == null) return null;
    return value == 'true' || value == '1';
  }

  // --- Other ---

  /// Returns the full URI of the current route.
  Uri get uri => state.uri;

  /// Returns the matched path of the current route.
  String? get path => state.matchedLocation;

  /// Returns the full location including query parameters.
  String get fullPath => state.uri.toString();

  /// Returns extra data passed to the route.
  Object? get extra => state.extra;

  /// Returns extra data cast to the specified type [T].
  T? extraAs<T>() => state.extra as T?;
}
