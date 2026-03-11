## 2.0.0

### Breaking Changes

- Constructor no longer takes a setup callback. Register routes directly on the instance.
- `get()` signature changed: handler is the second positional argument, middlewares is a named parameter.
- `WidgetResponse` constructor no longer requires `context`.

### New Features

- **Route groups**: `app.group('/prefix', (group) { ... })` for shared path prefixes
- **Shell routes**: `app.shell(builder, (shell) { ... })` for shared layouts via go_router's ShellRoute
- **Global middleware**: `app.use([middleware])` applies middleware to all routes
- **Named routes**: `app.get('/path', handler, name: 'routeName')`
- **Simple redirects**: `app.redirect('/from', '/to')`
- **Typed path parameters**: `req.intParam('id')`, `req.doubleParam('price')`
- **Typed query parameters**: `req.intQuery('page')`, `req.doubleQuery('price')`, `req.boolQuery('active')`
- **Typed extra**: `req.extraAs<MyType>()`
- **Lazy router**: Router is built on first access to `app.router`

### Bug Fixes

- Fix `res.redirect()` not working when middleware is present

## 1.0.4

- Fix README code examples

## 1.0.3

- Fix README code examples

## 1.0.2

- Fix Japanese documentation link

## 1.0.1

- Fix pubspec.yaml repository URL
- Fix Dart formatting issues

## 1.0.0

- Initial Release
