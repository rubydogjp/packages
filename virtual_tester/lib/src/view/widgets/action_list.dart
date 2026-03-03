import 'package:flutter/widgets.dart';
import 'package:virtual_tester/src/view/widgets/add_action_card.dart';

import '../../logic/test_action/types/test_action.dart';
import 'test_action_card.dart';

class ActionList extends StatelessWidget {
  const ActionList({
    super.key,
    required this.actions,
  });

  final List<TestAction> actions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // itemCount: actions.length + 1,
      itemCount: actions.length,
      itemBuilder: (_, index) {
        if (index < actions.length) {
          return TestActionCard(
            action: actions[index],
          );
        } else {
          return const AddActionCard();
        }
      },
    );
  }
}
