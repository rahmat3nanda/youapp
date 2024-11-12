import 'package:dio/dio.dart';
import 'package:youapp/data/models/response_model.dart';

class ErrorMapper {
  static ResponseModel dio(dynamic e) {
    ResponseModel response = ResponseModel(
      code: 0,
      success: false,
      message: "Unknown Error",
    );
    if (e == null) return response;
    if (e is DioException) {
      if (e.response == null) {
        response.message = "Error : ${e.message}";
        return response;
      }
      response.code = e.response?.statusCode ?? 0;
      response.message = e.response?.statusMessage ?? "Unknown Error";
      if (e.response?.data != null) {
        if (e.response?.data is Map) {
          Map<String, dynamic>? data = e.response?.data;
          if (data != null) {
            if (data["message"] != null) {
              if (data["message"] is String) {
                response.code = e.response?.statusCode ?? 0;
                response.message = data["message"];
              } else {
                response = ResponseModel.fromJson(data);
              }
            } else {
              response = ResponseModel.fromJson(data);
            }
          }
        } else {
          response.message = "\n${e.response?.data}";
        }
      }
      return response;
    }
    if (e is String) {
      response.message = e;
    } else if (e is! String) {
      response.message = "$e";
    } else {
      response.message = "Unknown Error";
    }
    return response;
  }
}
