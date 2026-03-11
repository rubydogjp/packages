import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/testing.dart';
import '../widgets/testing/action_list.dart';
import '../widgets/testing/playing_button.dart';
import '../widgets/testing/recording_button.dart';

class ActionListPage extends ConsumerWidget {
  const ActionListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(actionListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          const SizedBox(height: 10),
          const SizedBox(
            width: 120,
            height: 40,
            child: RecordingButton(),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            width: 120,
            height: 40,
            child: PlayingButton(),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ActionList(
              actions: actions,
            ),
          ),
        ],
      ),
    );
  }
}
