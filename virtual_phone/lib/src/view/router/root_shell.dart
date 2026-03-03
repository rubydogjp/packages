import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_phone/src/view/router/splash_shell.dart';

import '../../logic/config/types/config.dart';
import 'config_inherited.dart';
import 'locale_observer.dart';

class RootShell extends StatelessWidget {
  const RootShell({
    super.key,
    this.config,
    required this.child,
  });

  final Config? config;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }

    return ProviderScope(
      child: ConfigInherited(
        config: config,
        child: LocaleObserver(
          child: SplashShell(
            builder: (_) => child,
          ),
        ),
      ),
    );
  }
}
