import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/timeline_tweets/provider.dart';
import '../widgets/tweet_list.dart';

class TimelinePage extends ConsumerWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTweets = ref.watch(timelineTweetsProvider);

    return switch (asyncTweets) {
      AsyncData(value: final tweets) => TweetList(
          tweets: tweets,
        ),
      AsyncError() => const Center(
          child: Text('Error'),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
