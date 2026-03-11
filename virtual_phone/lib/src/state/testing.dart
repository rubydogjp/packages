import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/test_action.dart';

class ActionListNotifier extends Notifier<List<TestAction>> {
  @override
  List<TestAction> build() => [];

  void add(TestAction newActions) {
    state = [...state, newActions];
  }

  void replaceAll(List<TestAction> newActions) {
    state = newActions;
  }
}

class RecordingActionListNotifier extends Notifier<List<TestAction>> {
  @override
  List<TestAction> build() => [];

  void add(TestAction action) {
    state = [...state, action];
  }
}

class IsPlayingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void startPlaying() { state = true; }
  void stopPlaying() { state = false; }
}

class IsRecordingNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void startRecording() { state = true; }
  void stopRecording() { state = false; }
}

class DoingActionIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void set(String? id) { state = id; }
}

final actionListProvider =
    NotifierProvider<ActionListNotifier, List<TestAction>>(
  () => ActionListNotifier(),
);

final recordingActionListProvider =
    NotifierProvider<RecordingActionListNotifier, List<TestAction>>(
  () => RecordingActionListNotifier(),
);

final isPlayingProvider = NotifierProvider<IsPlayingNotifier, bool>(
  () => IsPlayingNotifier(),
);

final isRecordingProvider = NotifierProvider<IsRecordingNotifier, bool>(
  () => IsRecordingNotifier(),
);

final doingActionIdProvider = NotifierProvider<DoingActionIdNotifier, String?>(
  () => DoingActionIdNotifier(),
);
