import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase(this.userRepository);

  Future<UserModel?> execute() async {
    try {
      return await userRepository.fetch();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> executeLocal() async {
    try {
      return await userRepository.fetchFromLocal();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> executeRemote() async {
    try {
      return await userRepository.fetchFromRemote();
    } catch (e) {
      rethrow;
    }
  }
}
