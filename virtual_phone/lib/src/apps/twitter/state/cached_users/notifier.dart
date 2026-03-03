import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../external/user_api/provider.dart';
import '../../logic/user/types/user.dart';

typedef _State = List<User>;

class CachedUsersNotifier extends Notifier<_State> {
  @override
  List<User> build() {
    return [];
  }

  Future<void> add({
    required User newUser,
  }) async {
    addSome(newUsers: [newUser]);
  }

  Future<void> addSome({
    required List<User> newUsers,
  }) async {
    final oldList = state;
    final map = <String, User>{};
    for (final oldUser in oldList) {
      map[oldUser.id] = oldUser;
    }
    for (final newUser in newUsers) {
      map[newUser.id] = newUser;
    }
    final newList = map.values.toList();
    state = newList;
  }

  Future<void> fetchById({
    required String userId,
  }) async {
    final userApi = ref.read(userApiProvider);
    final newUser = await userApi.getById(id: userId);
    add(newUser: newUser);
  }

  Future<void> fetchByIds({
    required List<String> userIds,
  }) async {
    final userApi = ref.read(userApiProvider);
    final newUsers = await userApi.getSomeByIds(ids: userIds);
    addSome(newUsers: newUsers);
  }

  Future<void> rebuildByIds({
    required List<String> userIds,
  }) async {
    final userApi = ref.read(userApiProvider);
    state = await userApi.getSomeByIds(ids: userIds);
  }
}
