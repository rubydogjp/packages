import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/testing.dart';
import '../../presenters/action_list_player/provider.dart';

class StartPlayingButton extends ConsumerWidget {
  const StartPlayingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () async {
        final isPlayingNotifier = ref.read(isPlayingProvider.notifier);
        isPlayingNotifier.startPlaying();
        final player = ref.read(actionListPlayerProvider);
        await player.play();
        isPlayingNotifier.stopPlaying();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.white,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
