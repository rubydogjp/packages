import 'package:flutter/material.dart';

import '../../../logic/test_action/types/test_action.dart';
import '../../../state/doing_action_id/notifier.dart';
import '../virtual_tester/virtual_tester.dart';

class ActionListPlayer {
  const ActionListPlayer({
    required this.actions,
    required this.tester,
    required this.doingActionIdNotifier,
  });
  final List<TestAction> actions;
  final VirtualTester tester;
  final DoingActionIdNotifier doingActionIdNotifier;

  Future<void> play() async {
    for (final action in actions) {
      if (action is TapTestAction) {
        doingActionIdNotifier.set(action.id);
        await tester.moveTo(action.position);
        await tester.tap(action.position);
        await Future.delayed(const Duration(milliseconds: 500));
      } else {
        debugPrint('未対応のテストアクションです');
      }
    }
    doingActionIdNotifier.set(null);
  }
}
