import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kafiil_hiring_app/Const/Api_url.dart';


class DioHelper {
  static Dio? dio;

  static init() {
    debugPrint('dio helper run');
    dio = Dio(BaseOptions(
      validateStatus: (_) => true,
      baseUrl:ApiUrl.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    bool containImage = false,
    bool isJsonContentType = true,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      "Accept-Language": "ar",
      "Content-Type": "application/json"
    };
    print("This is data:$data");
    return dio!
        .post(
      url,
      data: containImage ? FormData.fromMap(data!) : data,
      queryParameters: query,
      options: Options(
          contentType: isJsonContentType
              ? Headers.jsonContentType
              : Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .catchError((error) {
      print(error.toString());
    });
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': '$token',
      "Accept-Language": "ar",
      'Accept': 'application/json',
    };
    return await dio!
        .get(
      url,
      queryParameters: query,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .catchError((error) {
      print(error.toString());
    });
  }
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio!
        .put(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    )
        .catchError((error) {
    });
  }
}
