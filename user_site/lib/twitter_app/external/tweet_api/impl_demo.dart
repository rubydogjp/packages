import '../../logic/tweet/types/tweet.dart';
import 'interface.dart';

class ImplDemo implements TweetApi {
  @override
  Future<List<Tweet>> getTimelineTweets() async {
    return const [
      Tweet(
        userId: '1',
        text: '今日もジャッキーが元気すぎるよ！#くまのがっこう',
        createdAt: '2 h',
      ),
      Tweet(
        userId: '2',
        text: '新しい料理を作ってみたけど、ジャッキーに食べられた…',
        createdAt: '3 h',
      ),
      Tweet(
        userId: '3',
        text: 'ジャッキーがいたずらばっかりしてるよ！でもかわいいから許すけどね。',
        createdAt: '1 h',
      ),
      Tweet(
        userId: '4',
        text: 'みんなでお出かけ！ジャッキーも楽しそう！',
        createdAt: '4 h',
      ),
      Tweet(
        userId: '5',
        text: '今日は雨。ジャッキーと一緒に絵本を読んで過ごしたよ。',
        createdAt: '5 h',
      ),
      Tweet(
        userId: '6',
        text: 'ジャッキーが新しい友達を連れてきた！みんなで仲良く遊んでる。',
        createdAt: '6 h',
      ),
      Tweet(
        userId: '7',
        text: 'ジャッキーが作ったお菓子、すごくおいしかった！',
        createdAt: '7 h',
      ),
      Tweet(
        userId: '8',
        text: '今日はジャッキーと一緒にお絵描きしたよ。彼女の想像力は本当に素晴らしい。',
        createdAt: '8 h',
      ),
      Tweet(
        userId: '9',
        text: 'ジャッキーと一緒に森へ探検に行った。新しい発見がいっぱい！',
        createdAt: '9 h',
      ),
      Tweet(
        userId: '10',
        text: 'ジャッキーがピアノを弾いてくれた。彼女の演奏は本当に心地いい。',
        createdAt: '10 h',
      ),
      Tweet(
        userId: '11',
        text: 'ジャッキーと一緒に映画を見た。とても楽しい時間を過ごしたよ。',
        createdAt: '11 h',
      ),
    ];
  }
}
