import 'package:flutter/material.dart';

import '../widgets/cursor_layer.dart';
import '../widgets/recording_action_detector.dart';

final testScopeKey = GlobalKey();

class TestScope extends StatelessWidget {
  const TestScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: testScopeKey,
      child: Stack(
        children: [
          child,
          const Positioned.fill(
            child: CursorLayer(),
          ),
          const Positioned.fill(
            child: RecordingActionDetector(),
          ),
        ],
      ),
    );
  }
}
