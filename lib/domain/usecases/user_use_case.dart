import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase(this.userRepository);

  Future<UserModel?> fetch() async {
    try {
      return await userRepository.fetch();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> fetchFromLocal() async {
    try {
      return await userRepository.fetchFromLocal();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> fetchFromRemote() async {
    try {
      return await userRepository.fetchFromRemote();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> destroy() async {
    await userRepository.destroy();
  }
}
