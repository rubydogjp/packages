import '../../logic/user/types/user.dart';

abstract interface class UserApi {
  Future<User> getById({
    required String id,
  });

  Future<List<User>> getSomeByIds({
    required List<String> ids,
  });
}
