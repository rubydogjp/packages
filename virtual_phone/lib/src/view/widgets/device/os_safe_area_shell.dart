import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../logic/device_model/device_model.dart';
import '../../../state/device_state.dart';
import '../keyboard/keyboard.dart';
import '../keyboard/keyboard_anchor.dart';
import 'os_settings_shell.dart';

/// Display a simulated on screen keyboard at the bottom of a [child] widget.
class OSSafeAreaShell extends ConsumerWidget {
  const OSSafeAreaShell({
    super.key,
    required this.os,
    required this.screen,
    required this.child,
  });

  final SoftwareOS os;
  final SoftwareScreen screen;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deviceStateProvider);
    var mediaQuery = MediaQuery.of(context);

    final insets = screen.safeAreaInset;
    final keyboardVisible = state.showKeyboard;
    final keyboardHeight = keyboardVisible ? os.keyboardHeight : 0.0;

    final safeArea = EdgeInsets.fromLTRB(
      insets.left,
      insets.top,
      insets.right,
      insets.bottom,
    );

    // When the keyboard covers more than the safe area, padding.bottom
    // becomes 0 (the keyboard itself acts as the bottom boundary).
    final paddingBottom =
        (keyboardVisible && os.keyboardHeight > insets.bottom)
            ? 0.0
            : insets.bottom;

    mediaQuery = mediaQuery.copyWith(
      viewInsets: mediaQuery.viewInsets.copyWith(
        bottom: mediaQuery.viewInsets.bottom + keyboardHeight,
      ),
      viewPadding: safeArea,
      padding: safeArea.copyWith(bottom: paddingBottom),
    );

    return MediaQuery(
      data: mediaQuery,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: screen.width,
            height: screen.height,
            child: OSSettingsShell(
              os: os,
              child: child,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: KeyboardAnchor(
              showKeyboard: state.showKeyboard,
              keyboard: Keyboard(height: os.keyboardHeight),
            ),
          ),
        ],
      ),
    );
  }
}
