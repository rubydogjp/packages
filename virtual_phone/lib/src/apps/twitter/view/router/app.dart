import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../theme/flutter_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCreator = FlutterThemeCreator();
    final theme = themeCreator.create(context);

    return MaterialApp(
      title: 'Twitter clone',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomePage(),
    );
  }
}
