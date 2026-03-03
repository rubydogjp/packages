import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../external/tweet_api/provider.dart';
import '../../logic/tweet/types/tweet.dart';
import '../cached_users/provider.dart';

typedef _State = List<Tweet>;

class TimelineTweetsNotifier extends AsyncNotifier<_State> {
  @override
  Future<List<Tweet>> build() async {
    final tweetApi = ref.read(tweetApiProvider);
    final tweets = await tweetApi.getTimelineTweets();
    final userIds = tweets.map((it) => it.userId);
    final cachedUsersNotifier = ref.read(
      cachedUsersProvider.notifier,
    );
    cachedUsersNotifier.fetchByIds(
      userIds: userIds.toList(),
    );
    return tweets;
  }

  Future<void> reload() async {
    state = await AsyncValue.guard(() {
      final tweetApi = ref.read(tweetApiProvider);
      return tweetApi.getTimelineTweets();
    });
  }
}
