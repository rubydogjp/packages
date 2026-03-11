import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../logic/device_model/device_model.dart';
import 'os_safe_area_shell.dart';

/// Display a simulated on screen keyboard at the bottom of a [app] widget.
class OSView extends ConsumerWidget {
  const OSView({
    super.key,
    required this.screen,
    required this.os,
    required this.app,
  });

  final SoftwareOS os;
  final SoftwareScreen screen;
  final Widget app;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // OSSettingsShell is already applied inside OSSafeAreaShell,
    // so we pass app directly to avoid double-wrapping.
    return Scaffold(
      body: OSSafeAreaShell(
        screen: screen,
        os: os,
        child: app,
      ),
    );
  }
}
