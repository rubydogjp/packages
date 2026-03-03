import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../external/user_api/provider.dart';
import '../../logic/user/creator.dart';
import '../../logic/user/types/user.dart';
import '../cached_users/provider.dart';

final userProvider = FutureProvider.family<User, String>(
  (ref, userId) async {
    final cachedUsers = ref.watch(cachedUsersProvider);

    final hitIndex = cachedUsers.indexWhere(
      (it) => it.id == userId,
    );

    if (hitIndex >= 0) {
      final cachedUser = cachedUsers[hitIndex];
      return cachedUser;
    }

    final userApi = ref.read(userApiProvider);
    final newUser = await userApi.getById(id: userId).onError(
      (_, __) {
        final userCreator = UserCreator();
        return userCreator.createNotFoundUser(id: userId);
      },
    );
    final cachedUsersNotifier = ref.read(
      cachedUsersProvider.notifier,
    );
    cachedUsersNotifier.add(newUser: newUser);
    return newUser;
  },
);
