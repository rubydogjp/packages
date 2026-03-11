# go_router_express

An Express.js-like wrapper for [go_router](https://pub.dev/packages/go_router).

## Usage

```dart
final app = GoRouterExpress();

app.get('/', (req, res) {
  res.page(const HomePage());
});

app.get('/users/:id', (req, res) {
  final id = req.intParam('id');
  res.page(UserPage(id: id!));
});

void main() {
  runApp(MaterialApp.router(routerConfig: app.router));
}
```

## Middleware

```dart
class AuthMiddleware extends WidgetMiddleware {
  @override
  Widget build(WidgetRequest req, WidgetResponse res, Widget Function() next) {
    if (req.query('token') == null) {
      return const Text('Unauthorized');
    }
    return next();
  }
}

// Per-route middleware
app.get('/admin', (req, res) {
  res.page(const AdminPage());
}, middlewares: [AuthMiddleware()]);

// Global middleware — applies to all routes
app.use([LoggingMiddleware()]);
```

## Route Groups

```dart
app.group('/api', (api) {
  api.get('/users', (req, res) { ... });   // matches /api/users
  api.get('/posts', (req, res) { ... });   // matches /api/posts
});
```

## Shell Routes

Shared layouts using go_router's ShellRoute:

```dart
app.shell(
  (context, state, child) => Scaffold(
    appBar: AppBar(title: const Text('Dashboard')),
    body: child,
  ),
  (shell) {
    shell.get('/home', (req, res) => res.page(const HomePage()));
    shell.get('/settings', (req, res) => res.page(const SettingsPage()));
  },
);
```

## Typed Parameters

```dart
app.get('/users/:id', (req, res) {
  final id = req.intParam('id');          // int?
  final price = req.doubleParam('price'); // double?
});

app.get('/search', (req, res) {
  final page = req.intQuery('page');       // int?
  final active = req.boolQuery('active');  // bool?
});
```

## Redirects

```dart
// Simple redirect
app.redirect('/old-page', '/new-page');

// Redirect in handler
app.get('/gate', (req, res) {
  res.redirect('/target');
});
```

## Named Routes

```dart
app.get('/users/:id', (req, res) {
  res.page(UserPage(id: req.params('id')!));
}, name: 'user');
```

## Navigation

go_router is re-exported, so all go_router extensions are available:

```dart
context.go('/details');
context.push('/details');
context.pop();
```

## Issues

For bug reports and feature requests, please visit:
[GitHub issues](https://github.com/rubydogjp/packages/issues)

## License

MIT

[📖 Japanese Documentation](https://github.com/rubydogjp/packages/blob/main/go_router_express/doc/ja/README.md)
