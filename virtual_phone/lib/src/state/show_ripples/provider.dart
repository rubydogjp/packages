import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notifier.dart';

final showRipplesProvider = NotifierProvider<ShowRipplesNotifier, bool>(
  () {
    return ShowRipplesNotifier();
  },
);
