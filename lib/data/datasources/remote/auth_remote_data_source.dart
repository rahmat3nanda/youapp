import 'package:get/get.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:youapp/data/models/response_model.dart';

class AuthRemoteDataSource {
  final ApiServiceDio _dio = Get.find();

  Future<String> login({
    required String emailOrUsername,
    required String password,
  }) async {
    try {
      d.Response response = await _dio.post(
        url: "login",
        body: {
          "email": emailOrUsername,
          "username": emailOrUsername,
          "password": password,
        },
      );

      String? token = response.data["access_token"];
      if (token != null) {
        return token;
      }

      throw ResponseModel(
        code: response.statusCode,
        success: false,
        message: response.data["message"],
      );
    } catch (e) {
      if (e is ResponseModel) {
        rethrow;
      }
      throw ErrorMapper.dio(e);
    }
  }

  Future<ResponseModel> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      d.Response response = await _dio.post(
        url: "register",
        body: {
          "email": email,
          "username": username,
          "password": password,
        },
      );

      ResponseModel data = ResponseModel(
        code: response.statusCode,
        success: response.statusCode == 201,
        message: response.data["message"] ?? response.statusMessage,
      );

      return data;
    } catch (e) {
      throw ErrorMapper.dio(e);
    }
  }
}
