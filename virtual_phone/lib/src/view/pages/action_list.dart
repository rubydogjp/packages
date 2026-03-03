import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/action_list/provider.dart';
import '../widgets/action_list.dart';
import '../widgets/playing_button.dart';
import '../widgets/recording_button.dart';

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
