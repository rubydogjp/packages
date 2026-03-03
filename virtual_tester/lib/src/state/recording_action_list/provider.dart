import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_tester/src/logic/test_action/types/test_action.dart';

import 'notifier.dart';

final recordingActionListProvider =
    NotifierProvider<RecordingActionListNotifier, List<TestAction>>(
  () {
    return RecordingActionListNotifier();
  },
);
