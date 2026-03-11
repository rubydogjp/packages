import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../logic/position.dart';
import '../../../logic/test_action.dart';
import '../../../state/testing.dart';

const uuidCreator = Uuid();

class RecordingActionDetector extends ConsumerWidget {
  const RecordingActionDetector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = ref.watch(isRecordingProvider);

    if (!isRecording) return const SizedBox();

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (details) {
        final uuid = uuidCreator.v4();
        final position = Position(
          x: details.localPosition.dx,
          y: details.localPosition.dy,
        );
        final tapAction = TapTestAction(
          id: uuid,
          position: position,
        );
        final recordingActionListNotifier = ref.read(
          recordingActionListProvider.notifier,
        );
        recordingActionListNotifier.add(tapAction);

        // TMP
        final actionListNotifier = ref.read(
          actionListProvider.notifier,
        );
        actionListNotifier.add(tapAction);
      },
      child: const SizedBox(),
    );
  }
}
