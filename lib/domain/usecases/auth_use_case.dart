import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<String> login({
    required String emailOrUsername,
    required String password,
  }) {
    return repository.login(
      emailOrUsername: emailOrUsername,
      password: password,
    );
  }

  Future<ResponseModel> register({
    required String email,
    required String username,
    required String password,
  }) {
    return repository.register(
      email: email,
      username: username,
      password: password,
    );
  }
}
