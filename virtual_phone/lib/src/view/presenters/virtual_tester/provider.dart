import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/cursor.dart';

import 'virtual_tester.dart';

final virtualTesterProvider = Provider<VirtualTester>(
  (ref) {
    final cursorPositionNotifier = ref.watch(cursorPositionProvider.notifier);
    final showRipplesNotifier = ref.watch(showRipplesProvider.notifier);
    return VirtualTester(
      cursorPositionNotifier: cursorPositionNotifier,
      showRipplesNotifier: showRipplesNotifier,
    );
  },
);
