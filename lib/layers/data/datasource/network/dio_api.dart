import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:dio/dio.dart';
import 'package:flutter_api_task_clean_architecture/core/utils/export.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../config/constants/export.dart';
import '../../models/response/base_response.dart';

enum HttpRequestType {
  get,
  post,
}

abstract class DioApi {
  Dio create();
  Future<BaseResponse<T>> request<T>({
    String? item,
    String? loadingText,
    bool showError = true,
    bool showLoading = true,
    required String endpoint,
    Map<String, dynamic>? params,
    T? Function(Object object)? cast,
    Map<String, dynamic>? requestBody,
    required HttpRequestType httpRequestType,
    required dynamic Function(Map<String, dynamic> json) fromJsonT,
  });
}

class DioApiImpl extends DioApi {
  static const bool enableLogger = true;

  static DioApiImpl? instance;
  late final Dio _dio;
  factory DioApiImpl() {
    return instance ??= DioApiImpl._internal();
  }
  DioApiImpl._internal() {
    _dio = create();
  }

  @override
  Dio create() {
    final options = BaseOptions(
      baseUrl: '${ApiEndpoints.baseUrl}',
      contentType: 'application/json',
      sendTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    final dio = Dio(options);

    // dio.interceptors.addAll({
    //   AppInterceptors(dio),
    // });

    return dio;
  }

  @override
  Future<BaseResponse<T>> request<T>({
    String? item,
    String? loadingText,
    bool showError = true,
    bool showLoading = true,
    required String endpoint,
    Map<String, dynamic>? params,
    T? Function(Object object)? cast,
    Map<String, dynamic>? requestBody,
    required HttpRequestType httpRequestType,
    required dynamic Function(Map<String, dynamic> json) fromJsonT,
  }) async {
    Response<dynamic> response;

    late String errorMessage;

    var path = endpoint;

    if (item != null) {
      path = '$endpoint/$item';
    }

    final result = await ConnectivityUtilImpl().checkConnectivity();

    if (result) {
      log('Request Body ${requestBody.toString()}');
      try {
        requestBody ??= {};

        switch (httpRequestType) {
          case HttpRequestType.get:
            response = await _dio.get(
              path,
              queryParameters: params,
            );
          case HttpRequestType.post:
            response = await _dio.post(
              path,
              data: requestBody,
              queryParameters: params,
            );
        }
        log("Response");
        log(response.data.toString());

        final baseRespsone = BaseResponse<T>.fromJson(
          response.data as Map<String, dynamic>,
          (json) {
            if (json is List) {
              final list = json.map((e) {
                final x = fromJsonT(e as Map<String, dynamic>);
                return x;
              }).toList();
              return cast!(list) as T;
            } else {
              return fromJsonT(json! as Map<String, dynamic>) as T;
            }
          },
        );

        if (!(baseRespsone.code == 200)) {
          return BaseResponse(code: 400, status: response.statusMessage!);
        }

        return baseRespsone;
      } on DioException catch (e) {
        errorMessage = e.message!;

        if (e.response != null) {
          final resposne = e.response!;

          errorMessage = resposne.statusMessage!;

          final statusCode = resposne.statusCode;

          if (statusCode == 400) {
            // ignore: avoid_dynamic_calls

            var message = resposne.data['message'];
            if (message is List) {
              errorMessage = '';
              for (var element in message) {
                errorMessage += element;
              }
            } else {
              errorMessage = message;
            }
          }

          if (enableLogger) {
            log('DioUtil::request()::URL: ${resposne.realUri}');
            log('DioUtil::request()::Status Code: $statusCode');
            log('DioUtil::request()::Request Data: ${resposne.requestOptions.data}');
            log('DioUtil::request()::Response Data: ${resposne.data}');
            log('DioUtil::request()::Message: ${resposne.statusMessage}');
          }
          if (resposne.statusMessage == "Found") {
            errorMessage = "Unexpected Error Occured";
          }
        } else {
          if (enableLogger) {
            log('DioUtil::request()::Message: ${e.message}');
          }
          if (e.type == DioExceptionType.connectionError) {
            errorMessage = 'Connection unstable please check your internet';
            log('Connection unstable Please check you internet for endpoint $endpoint');
          }
          if (e.type == DioExceptionType.connectionTimeout) {
            errorMessage = 'Connection timeout please check your internet';
            log('Connection timeout please check you internet for endpoint $endpoint');
          }
          if (e.type == DioExceptionType.receiveTimeout) {
            errorMessage = 'Receive timeout please check your internet';
            log('Receive timeout please check your internet for endpoint $endpoint');
          }
          if (e.type == DioExceptionType.sendTimeout) {
            errorMessage =
                'This request take longer please check your internet and try again';
            log('This request take longer please check your internet and try again for endpoint $endpoint');
          }
        }
      }
      // on Error catch (e) {
      //   FlutterToastUtil.showToast(text: e.toString());
      //   errorMessage = e.toString();
      // }
    } else {
      errorMessage = 'Internet is not connected';
    }

    return BaseResponse(code: 400, status: errorMessage);
  }
}
