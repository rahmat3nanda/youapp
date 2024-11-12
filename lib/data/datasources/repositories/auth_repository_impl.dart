import 'package:youapp/data/datasources/remote/auth_remote_data_source.dart';
import 'package:youapp/data/models/response_model.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      String token = await remoteDataSource.login(
        emailOrUsername: emailOrUsername,
        password: password,
      );
      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      ResponseModel data = await remoteDataSource.register(
        email: email,
        username: username,
        password: password,
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
