import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/test_action/types/test_action.dart';

class RecordingActionListNotifier extends Notifier<List<TestAction>> {
  @override
  List<TestAction> build() {
    return [];
  }

  add(TestAction action) {
    final newList = [...state, action];
    state = newList;
  }
}
