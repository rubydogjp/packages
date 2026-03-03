import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoingActionIdNotifier extends Notifier<String?> {
  @override
  String? build() {
    return null;
  }

  void set(String? id) {
    state = id;
  }
}
