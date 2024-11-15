import 'package:get/get.dart';
import 'package:youapp/app/helpers/error_mapper.dart';
import 'package:youapp/data/datasources/api_service_dio.dart';
import 'package:youapp/data/models/user_model.dart';
import 'package:dio/dio.dart' as d;

class UserRemoteDataSource {
  final ApiServiceDio _dio = Get.find();

  Future<UserModel> fetch() async {
    try {
      d.Response response = await _dio.get(url: "getProfile");
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      throw ErrorMapper.dio(e);
    }
  }

  Future<UserModel> update(UserModel data) async {
    try {
      d.Response response = await _dio.put(
        url: "updateProfile",
        body: data.toJson(),
      );
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      throw ErrorMapper.dio(e);
    }
  }
}
