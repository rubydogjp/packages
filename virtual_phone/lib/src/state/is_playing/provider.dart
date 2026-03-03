import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';

final isPlayingProvider = NotifierProvider<IsPlayingNotifier, bool>(
  () {
    return IsPlayingNotifier();
  },
);
