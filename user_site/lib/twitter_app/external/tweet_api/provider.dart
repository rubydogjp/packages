import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'impl_demo.dart';
import 'interface.dart';

final tweetApiProvider = Provider<TweetApi>(
  (ref) {
    return ImplDemo();
  },
);
