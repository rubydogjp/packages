import '../../logic/tweet/types/tweet.dart';

abstract interface class TweetApi {
  Future<List<Tweet>> getTimelineTweets();
}
