import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/is_recording/provider.dart';
import 'start_recording_button.dart';
import 'stop_recording_button.dart';

class RecordingButton extends ConsumerWidget {
  const RecordingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = ref.watch(isRecordingProvider);

    if (isRecording) {
      return const StopRecordingButton();
    } else {
      return const StartRecordingButton();
    }
  }
}
