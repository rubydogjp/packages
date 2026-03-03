import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/is_playing/provider.dart';
import 'start_playing_button.dart';
import 'stop_playing_button.dart';

class PlayingButton extends ConsumerWidget {
  const PlayingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(isPlayingProvider);
    if (isPlaying) {
      return const StopPlayingButton();
    } else {
      return const StartPlayingButton();
    }
  }
}
