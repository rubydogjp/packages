import 'package:flutter/material.dart';

import '../../logic/tweet/types/tweet.dart';
import 'tweet_card.dart';
import 'tweet_separater.dart';

class TweetList extends StatelessWidget {
  const TweetList({
    super.key,
    required this.tweets,
  });

  final List<Tweet> tweets;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tweets.length,
      itemBuilder: (_, index) => TweetCard(
        tweet: tweets[index],
      ),
      separatorBuilder: (_, __) => const TweetSeparater(),
    );
  }
}
