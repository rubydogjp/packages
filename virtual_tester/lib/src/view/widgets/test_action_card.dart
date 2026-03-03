import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/test_action/types/test_action.dart';
import '../../state/doing_action_id/provider.dart';

class TestActionCard extends ConsumerWidget {
  const TestActionCard({
    super.key,
    required this.action,
  });

  final TestAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doingActionId = ref.watch(doingActionIdProvider);

    if (action is TapTestAction) {
      return _TapAction(
        isDoing: action.id == doingActionId,
      );
    } else {
      return const Placeholder();
    }
  }
}

class _TapAction extends StatelessWidget {
  const _TapAction({
    required this.isDoing,
  });

  final bool isDoing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          color: isDoing ? Colors.blue : Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text(
          'タップ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
