import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/finger_cursor_position/provider.dart';
import '../../state/show_ripples/provider.dart';
import 'ripples.dart';
import 'finger_cursor.dart';

class CursorLayer extends ConsumerWidget {
  const CursorLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cursorPosition = ref.watch(cursorPositionProvider);
    final showRipples = ref.watch(showRipplesProvider);

    return Stack(
      children: [
        if (showRipples)
          Positioned(
            left: cursorPosition.x,
            top: cursorPosition.y,
            child: Transform.translate(
              offset: const Offset(-20, -20),
              child: const SizedBox(
                width: 40,
                height: 40,
                child: IgnorePointer(
                  child: Ripples(size: 40),
                ),
              ),
            ),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          left: cursorPosition.x,
          top: cursorPosition.y,
          child: Transform.translate(
            offset: const Offset(-50, 0),
            child: const SizedBox(
              width: 100,
              height: 100,
              child: IgnorePointer(
                child: FingerCursor(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
