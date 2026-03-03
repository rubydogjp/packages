import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsPlayingNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void startPlaying() {
    state = true;
  }

  void stopPlaying() {
    state = false;
  }
}
