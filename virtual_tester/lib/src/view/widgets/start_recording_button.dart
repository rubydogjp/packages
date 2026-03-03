import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/is_recording/provider.dart';

class StartRecordingButton extends ConsumerWidget {
  const StartRecordingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () {
        final notifier = ref.read(isRecordingProvider.notifier);
        notifier.startRecording();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.white,
      ),
      label: const Text(
        'Record',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
