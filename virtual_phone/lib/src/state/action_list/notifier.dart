import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/test_action/types/test_action.dart';

class ActionListNotifier extends Notifier<List<TestAction>> {
  @override
  List<TestAction> build() {
    return [];
  }

  void add(TestAction newActions) {
    final newList = [...state, newActions];
    state = newList;
  }

  void replaceAll(List<TestAction> newActions) {
    state = newActions;
  }
}
