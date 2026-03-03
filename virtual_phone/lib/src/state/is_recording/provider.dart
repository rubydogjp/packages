import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';

final isRecordingProvider = NotifierProvider<IsRecordingNotifier, bool>(
  () {
    return IsRecordingNotifier();
  },
);
