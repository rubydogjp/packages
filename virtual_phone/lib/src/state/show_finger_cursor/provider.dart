import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../is_playing/provider.dart';

final showFingerCursorProvider = Provider<bool>(
  (ref) {
    final isPlaying = ref.watch(isPlayingProvider);
    return isPlaying;
  },
);
