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

/// Sign-in state. Guards re-run whenever it changes.
final signedIn = ValueNotifier(false);

final app = GoRouterExpress(refreshListenable: signedIn);

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

  // Guard — only signed-in users can see their account
  app.get('/account', (req, res) {
    res.page(const AccountPage());
  }, guards: [(req) => signedIn.value ? null : '/sign-in']);

  app.get('/sign-in', (req, res) {
    res.page(const SignInPage());
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/account'),
              child: const Text('Account (guarded)'),
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

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signedIn.value = true;
            context.go('/account');
          },
          child: const Text('Sign in'),
        ),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Center(
        child: ElevatedButton(
          // The guard sends the user to /sign-in as soon as this changes.
          onPressed: () => signedIn.value = false,
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
