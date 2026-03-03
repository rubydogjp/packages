import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialModelIdNotifier extends AsyncNotifier<String> {
  final completer = Completer<String>();

  @override
  Future<String> build() async {
    return completer.future;
  }

  void initialize(String modelId) {
    if (completer.isCompleted) return;
    completer.complete(modelId);
  }
}
