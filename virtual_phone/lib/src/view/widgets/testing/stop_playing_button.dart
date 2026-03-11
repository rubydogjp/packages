import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/testing.dart';

class StopPlayingButton extends ConsumerWidget {
  const StopPlayingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () {
        final notifier = ref.read(isPlayingProvider.notifier);
        notifier.stopPlaying();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      icon: const Icon(
        Icons.pause,
        color: Colors.white,
      ),
      label: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
