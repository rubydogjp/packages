import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/test_action/types/test_action.dart';

class ActionListNotifier extends Notifier<List<TestAction>> {
  @override
  List<TestAction> build() {
    return [];
  }

  add(TestAction newActions) {
    final newList = [...state, newActions];
    state = newList;
  }

  replaceAll(List<TestAction> newActions) {
    state = newActions;
  }
}
