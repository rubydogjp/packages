import 'package:flutter/material.dart';

import '../src/view/pages/home.dart';

abstract class VirtualPhone {
  static Locale? locale(BuildContext context) {
    return HomePage.getLocale(context);
  }

  static Widget builder(
    BuildContext context,
    Widget? child,
  ) {
    return HomePage(
      app: child ?? const SizedBox.shrink(),
    );
  }
}
