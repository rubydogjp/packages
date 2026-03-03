import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/tweet/types/tweet.dart';
import 'notifier.dart';

final timelineTweetsProvider =
    AsyncNotifierProvider<TimelineTweetsNotifier, List<Tweet>>(
  () {
    return TimelineTweetsNotifier();
  },
);
