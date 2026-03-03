import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/doing_action_id/provider.dart';
import '../../../state/action_list/provider.dart';
import '../virtual_tester/provider.dart';
import 'action_list_player.dart';

final actionListPlayerProvider = Provider<ActionListPlayer>(
  (ref) {
    final actions = ref.watch(actionListProvider);
    final tester = ref.watch(virtualTesterProvider);
    final doingActionIdNotifier = ref.watch(doingActionIdProvider.notifier);

    return ActionListPlayer(
      tester: tester,
      actions: actions,
      doingActionIdNotifier: doingActionIdNotifier,
    );
  },
);
