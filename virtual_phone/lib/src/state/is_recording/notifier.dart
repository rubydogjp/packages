import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsRecordingNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void startRecording() {
    state = true;
  }

  void stopRecording() {
    state = false;
  }
}
