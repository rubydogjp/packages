import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/test_action/types/test_action.dart';
import 'notifier.dart';

final actionListProvider =
    NotifierProvider<ActionListNotifier, List<TestAction>>(
  () {
    return ActionListNotifier();
  },
);
