## 4.1.0

### New Features

- **Route guards**: `RouteGuard` decides whether a request may reach its route, returning `null` to let it through or a location to redirect to. Guards run before the page is built (backed by go_router's `redirect`), so a guarded page never flashes on screen, and they may be async.
  - `app.guard(guard)` on the app or any group / shell applies to every route inside it
  - `guards:` parameter on `get()` and `shell()`
  - Run outermost first (app → group → shell → route) and stop at the first redirect
- **`refreshListenable`** on `GoRouterExpress` re-runs guards whenever it notifies (e.g. on sign-out).

### Other

- Bump `go_router` to ^18.1.2.

## 4.0.0

### Breaking Changes

- Upgrade to `go_router` ^18.0.0 (re-exported, so consumers receive go_router 18's API, which is now backed by the standalone `material_ui` and `cupertino_ui` packages).
- Require Flutter 3.47.2 / Dart 3.13.0.

### Other

- Bump `lints` to 6.1.0.

## 3.0.0

### Breaking Changes

- Upgrade to `go_router` ^17.0.0 (re-exported, so consumers receive go_router 17's API).
- Require Flutter 3.44.1 / Dart 3.12.0.

## 2.0.1

- Require Flutter 3.41.2 / Dart 3.11.0

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
