import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:youapp/app/constants/app_log.dart';
import 'package:youapp/data/datasources/api_service.dart';

class ApiServiceDio extends ApiService {
  late Dio _dio;

  ApiServiceDio({required String baseUrl, Map<String, dynamic>? headers}) {
    _dio = Dio();
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers ??
          {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: (RequestOptions o, RequestInterceptorHandler h) {
        AppLog.print("URL request : ${o.uri}");
        return h.next(o);
      }, onResponse: (Response r, ResponseInterceptorHandler h) {
        return h.next(r);
      }, onError: (DioException e, ErrorInterceptorHandler h) async {
        AppLog.print("URL error : ${e.requestOptions.path}");
        return h.next(e);
      }),
    );
  }

  void setToken(String token) {
    _dio.options.headers["x-access-token"] = token;
  }

  @override
  Future post({required String url, body, Map<String, dynamic>? param}) async {
    try {
      return await _dio.post(
        url,
        queryParameters: param,
        data: body,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future patch({
    required String url,
    required dynamic body,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.patch(
        url,
        queryParameters: param,
        data: body,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future get({
    required String url,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: param,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future delete({
    required String url,
    dynamic body,
    Map<String, dynamic>? param,
  }) async {
    try {
      return await _dio.delete(
        url,
        queryParameters: param,
        data: body,
      );
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      return Future.error(e);
    } on DioException catch (e) {
      return Future.error(e);
    }
  }
}
