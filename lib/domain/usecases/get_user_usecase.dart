import 'package:youapp/data/models/user_model.dart';
import 'package:youapp/domain/repositories/user_repository.dart';

class GetUserDataUseCase {
  final UserRepository userRepository;

  GetUserDataUseCase(this.userRepository);

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

  Future<String?> executeToken() {
    return userRepository.fetchToken();
  }
}
