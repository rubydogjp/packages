import '../../logic/user/types/user.dart';
import 'interface.dart';

class ImplDemo implements UserApi {
  @override
  Future<User> getById({required String id}) async {
    throw Exception('User not found');
  }

  @override
  Future<List<User>> getSomeByIds({
    required List<String> ids,
  }) async {
    return const [
      User(
        id: '1',
        atName: 'dicky',
        iconUri: 'assets/images/user-01.png',
        nickname: 'Dicky',
      ),
      User(
        id: '2',
        atName: 'wulli',
        iconUri: 'assets/images/user-02.png',
        nickname: 'Wulli',
      ),
      User(
        id: '3',
        atName: 'anton',
        iconUri: 'assets/images/user-03.png',
        nickname: 'Anton',
      ),
      User(
        id: '4',
        atName: 'albert',
        iconUri: 'assets/images/user-04.png',
        nickname: 'Albert',
      ),
      User(
        id: '5',
        atName: 'max',
        iconUri: 'assets/images/user-05.png',
        nickname: 'Max',
      ),
      User(
        id: '6',
        atName: 'toffe',
        iconUri: 'assets/images/user-06.png',
        nickname: 'Toffe',
      ),
      User(
        id: '7',
        atName: 'harry',
        iconUri: 'assets/images/user-07.png',
        nickname: 'Harry',
      ),
      User(
        id: '8',
        atName: 'bernard',
        iconUri: 'assets/images/user-08.png',
        nickname: 'Bernard',
      ),
      User(
        id: '9',
        atName: 'peter',
        iconUri: 'assets/images/user-09.png',
        nickname: 'Peter',
      ),
      User(
        id: '10',
        atName: 'herman',
        iconUri: 'assets/images/user-10.png',
        nickname: 'Herman',
      ),
      User(
        id: '11',
        atName: 'roy',
        iconUri: 'assets/images/user-11.png',
        nickname: 'Roy',
      ),
    ];
  }
}
