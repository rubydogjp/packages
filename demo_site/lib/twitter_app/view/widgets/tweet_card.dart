import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../temp/temp_profile_page.dart';
import 'user_icon.dart';
import '../../logic/tweet/types/tweet.dart';
import '../../state/user/provider.dart';
import '../theme/color_palette.dart';

class TweetCard extends ConsumerWidget {
  const TweetCard({
    super.key,
    required this.tweet,
  });

  final Tweet tweet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pallete = ColorPalette.of(context);

    final asyncUser = ref.watch(userProvider(tweet.userId));

    final userIcon = switch (asyncUser) {
      AsyncData(value: final user) => UserIcon(uri: user.iconUri),
      AsyncError() => const Icon(Icons.person),
      _ => const CircularProgressIndicator(),
    };

    final userNickname = switch (asyncUser) {
      AsyncData(value: final user) => Text(
          user.nickname,
          style: TextStyle(color: pallete.strongText),
        ),
      AsyncError() => Text(
          '...',
          style: TextStyle(color: pallete.strongText),
        ),
      _ => Text(
          '...',
          style: TextStyle(color: pallete.strongText),
        ),
    };

    final userAtName = switch (asyncUser) {
      AsyncData(value: final user) => Text(
          '@${user.atName}・${tweet.createdAt}',
          style: const TextStyle(color: Colors.grey),
        ),
      AsyncError() => const Text(
          '...',
          style: TextStyle(color: Colors.grey),
        ),
      _ => const Text(
          '...',
          style: TextStyle(color: Colors.grey),
        ),
    };

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ProfileScreen(),
          ),
        );
      },
      child: Container(
        color: pallete.card,
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 15,
              child: userIcon,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      userNickname,
                      const SizedBox(width: 5.0),
                      userAtName,
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    tweet.text,
                    style: TextStyle(color: pallete.strongText),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: pallete.weakText,
                        size: 14.0,
                      ),
                      const SizedBox(width: 30.0),
                      Icon(
                        Icons.repeat_sharp,
                        color: pallete.weakText,
                        size: 14.0,
                      ),
                      const SizedBox(width: 30.0),
                      Icon(
                        Icons.favorite_outline,
                        color: pallete.weakText,
                        size: 14.0,
                      ),
                      const SizedBox(width: 30.0),
                      Icon(
                        Icons.bar_chart_rounded,
                        color: pallete.weakText,
                        size: 14.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
