import 'types/user.dart';

class UserCreator {
  User createNotFoundUser({
    required String id,
  }) {
    return User(
      id: id,
      atName: '???',
      iconUri: 'user-not-found.png',
      nickname: 'NotFound',
    );
  }
}
