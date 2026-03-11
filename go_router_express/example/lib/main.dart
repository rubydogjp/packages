import 'package:flutter/material.dart';
import 'package:go_router_express/go_router_express.dart';

// --- Middleware ---

class LoggingMiddleware extends WidgetMiddleware {
  @override
  Widget build(WidgetRequest req, WidgetResponse res, Widget Function() next) {
    debugPrint('[LOG] ${req.path}');
    return next();
  }
}

// --- App setup ---

final app = GoRouterExpress();

void setupRoutes() {
  // Global middleware — applies to all routes
  app.use([LoggingMiddleware()]);

  // Simple routes
  app.get('/', (req, res) {
    res.page(const HomePage());
  });

  app.get('/details', (req, res) {
    res.page(const DetailsPage());
  });

  // Typed path parameters
  app.get('/users/:id', (req, res) {
    final id = req.intParam('id');
    res.page(UserPage(id: id ?? 0));
  }, name: 'user');

  // Route group — shared prefix
  app.group('/settings', (settings) {
    settings.get('/profile', (req, res) {
      res.page(const Center(child: Text('Profile Settings')));
    });
    settings.get('/theme', (req, res) {
      res.page(const Center(child: Text('Theme Settings')));
    });
  });

  // Redirect
  app.redirect('/home', '/');
}

void main() {
  setupRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: app.router);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/details'),
              child: const Text('Go to Details'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/users/42'),
              child: const Text('View User 42'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/settings/profile'),
              child: const Text('Profile Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to Home'),
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User $id')),
      body: Center(child: Text('User ID: $id')),
    );
  }
}
