import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/position.dart';
import 'testing.dart';

class CursorPositionNotifier extends Notifier<Position> {
  @override
  Position build() {
    return const Position(x: 0, y: 0);
  }

  Future<void> moveTo(Position newPosition) async {
    state = newPosition;
  }
}

class ShowRipplesNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void show() { state = true; }
  void hide() { state = false; }
}

final cursorPositionProvider =
    NotifierProvider<CursorPositionNotifier, Position>(
  () => CursorPositionNotifier(),
);

final showRipplesProvider = NotifierProvider<ShowRipplesNotifier, bool>(
  () => ShowRipplesNotifier(),
);

final showFingerCursorProvider = Provider<bool>(
  (ref) => ref.watch(isPlayingProvider),
);
