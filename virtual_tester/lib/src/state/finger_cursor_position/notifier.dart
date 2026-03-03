import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/finger_cursor/types/position.dart';

class CursorPositionNotifier extends Notifier<Position> {
  @override
  Position build() {
    return const Position(
      x: 0,
      y: 0,
    );
  }

  Future<void> moveTo(Position newPosition) async {
    state = newPosition;
  }
}
