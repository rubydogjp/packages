import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/is_recording/provider.dart';

class StopRecordingButton extends ConsumerWidget {
  const StopRecordingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () {
        final isRecordingNotifier = ref.read(isRecordingProvider.notifier);
        isRecordingNotifier.stopRecording();
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
