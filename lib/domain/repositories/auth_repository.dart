import 'package:youapp/data/models/response_model.dart';

abstract class AuthRepository {
  Future<String> login({
    required String emailOrUsername,
    required String password,
  });

  Future<ResponseModel> register({
    required String email,
    required String username,
    required String password,
  });
}
