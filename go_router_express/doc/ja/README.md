# go_router_express

Flutter (Android/iOS) で使うためのパッケージ

- go_router を薄くラップした (かなり依存強め. 最新の v16系統に対応)
- node.js の express のような書き心地
- response で json ではなく widget を返せることが特徴. Scaffold で作られた widget を想定

## インストール

```yaml
dependencies:
  go_router_express: ^2.0.0
```

## 基本的な使い方

```dart
final app = GoRouterExpress();

app.get('/todos/:id', (req, res) {
  final id = req.params('id');
  res.page(TodoPage(id: id!));
});

void main() {
  runApp(MaterialApp.router(routerConfig: app.router));
}
```

## ミドルウェア

```dart
class AuthMiddleware extends WidgetMiddleware {
  @override
  Widget build(WidgetRequest req, WidgetResponse res, Widget Function() next) {
    if (req.query('token') == null) {
      return UnauthorizedPage();
    }
    return next();
  }
}

// ルートごとのミドルウェア
app.get('/admin', (req, res) {
  res.page(AdminPage());
}, middlewares: [AuthMiddleware()]);

// グローバルミドルウェア — 全ルートに適用
app.use([LoggingMiddleware()]);
```

## ルートグループ

共通のパスプレフィックスでルートをグループ化:

```dart
app.group('/api', (api) {
  api.get('/users', handler);   // /api/users にマッチ
  api.get('/posts', handler);   // /api/posts にマッチ
});

// ネストも可能
app.group('/api', (api) {
  api.group('/v1', (v1) {
    v1.get('/users', handler);  // /api/v1/users にマッチ
  });
});
```

## シェルルート

go_router の ShellRoute による共通レイアウト:

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

## 型付きパラメータ

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

## リダイレクト

```dart
// シンプルなリダイレクト
app.redirect('/old-page', '/new-page');

// ハンドラ内でのリダイレクト
app.get('/gate', (req, res) {
  res.redirect('/target');
});
```

## 名前付きルート

```dart
app.get('/users/:id', (req, res) {
  res.page(UserPage(id: req.params('id')!));
}, name: 'user');
```

## 画面遷移

go_router を re-export しているため、全ての go_router の拡張機能が使えます:

```dart
// go - スタックを置き換え
context.go('/next-page');

// push - スタックに追加
context.push('/detail-page');

// pop - 戻る
context.pop();
```

## API

**GoRouterExpress**
- `get(String path, RouteHandler handler, {middlewares, name})` - ルート登録
- `use(List<WidgetMiddleware> middlewares)` - グローバルミドルウェア追加
- `group(String prefix, void Function(RouteGroup) setup)` - ルートグループ
- `shell(builder, void Function(RouteGroup) setup)` - シェルルート
- `redirect(String from, String to)` - リダイレクト登録
- `router` - MaterialApp.router() に渡す GoRouter インスタンス

**WidgetRequest**
- `params(String name)` - パスパラメータ取得 (String?)
- `intParam(String name)` - パスパラメータを int で取得
- `doubleParam(String name)` - パスパラメータを double で取得
- `query(String name)` - クエリパラメータ取得 (String?)
- `intQuery(String name)` - クエリパラメータを int で取得
- `doubleQuery(String name)` - クエリパラメータを double で取得
- `boolQuery(String name)` - クエリパラメータを bool で取得
- `pathParams` - 全パスパラメータ
- `queryParams` - 全クエリパラメータ
- `extraAs<T>()` - 型付き extra データ取得

**WidgetResponse**
- `page(Widget widget)` - ページ Widget を返す
- `redirect(String location)` - リダイレクト

**WidgetMiddleware**
- `build(WidgetRequest req, WidgetResponse res, Widget Function() next)` - ミドルウェア処理

**RouteGroup**
- `get()`, `use()`, `group()`, `shell()`, `redirect()` - GoRouterExpress と同じ API

## v1 → v2 移行ガイド

```dart
// v1
final app = GoRouterExpress((app) {
  app.get('/path', [middleware], handler);
});

// v2
final app = GoRouterExpress();
app.get('/path', handler, middlewares: [middleware]);
```

主な変更点:
- コンストラクタからセットアップコールバックを削除
- `get()` の引数順: `(path, handler, {middlewares, name})`
- `WidgetResponse` のコンストラクタから `context` を削除

## Issues

バグ報告や機能リクエストは以下へお願いします:
https://github.com/rubydogjp/packages/issues

## ライセンス

MIT
