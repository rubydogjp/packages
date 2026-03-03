import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../logic/user/types/user.dart';
import 'notifier.dart';

final cachedUsersProvider = NotifierProvider<CachedUsersNotifier, List<User>>(
  () {
    return CachedUsersNotifier();
  },
);
