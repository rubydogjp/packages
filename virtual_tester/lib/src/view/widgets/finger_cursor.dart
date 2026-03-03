import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/show_finger_cursor.dart/provider.dart';

class FingerCursor extends ConsumerWidget {
  const FingerCursor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(showFingerCursorProvider);

    if (!show) return const SizedBox.shrink();

    return Image.asset(
      package: 'virtual_tester',
      'assets/images/finger-cursor.png',
    );
  }
}
