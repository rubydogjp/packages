import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';

final doingActionIdProvider = NotifierProvider<DoingActionIdNotifier, String?>(
  () {
    return DoingActionIdNotifier();
  },
);
