import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/cursor.dart';

class FingerCursor extends ConsumerWidget {
  const FingerCursor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(showFingerCursorProvider);

    if (!show) return const SizedBox.shrink();

    return Image.asset(
      package: 'virtual_phone',
      'assets/images/finger-cursor.png',
    );
  }
}
