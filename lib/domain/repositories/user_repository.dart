import 'package:youapp/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> fetch();

  Future<UserModel?> fetchFromLocal();

  Future<UserModel?> fetchFromRemote();

  Future<void> destroy();
}
