import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/finger_cursor/types/position.dart';
import 'notifier.dart';

final cursorPositionProvider =
    NotifierProvider<CursorPositionNotifier, Position>(
  () {
    return CursorPositionNotifier();
  },
);
