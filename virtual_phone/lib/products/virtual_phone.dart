import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../src/view/pages/home.dart';

abstract class VirtualPhone {
  static Locale? locale(BuildContext context) {
    return HomePage.getLocale(context);
  }

  static Widget builder(BuildContext context, Widget? child) {
    final app = child ?? const SizedBox.shrink();

    // Like VirtualPhoneScope, the simulator only runs on the web.
    // Elsewhere the app is shown as is.
    if (!kIsWeb) return app;

    return HomePage(app: app);
  }
}
