import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowRipplesNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}
