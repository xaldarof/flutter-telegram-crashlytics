import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/foundation.dart';

extension ResponseExt on Response {
  bool get isSuccessful => statusCode == 200;
}

class DioClient {
  final String _baseUrl = "https://api.telegram.org/";
  late Dio _dio;

  DioClient() {
    _dio = Dio();
    if (kDebugMode) {
      if (_dio.interceptors.isEmpty == true) {
        _dio.interceptors.add(
          DioLoggingInterceptor(
            level: Level.body,
            compact: false,
          ),
        );
      }
    }
  }

  Future<BaseOptions> _getOptions() async {
    return BaseOptions(
      baseUrl: _baseUrl,
      responseType: ResponseType.plain,
      connectTimeout: 3000,
      receiveTimeout: 3000,
      validateStatus: (code) {
        if (code! >= 200 && code <= 400) {
          return true;
        } else {
          return false;
        }
      },
    );
  }

  CancelToken cancelToken() {
    return CancelToken();
  }

  Future<Response<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    _dio.options = await _getOptions();
    return _dio.post<T>(path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
  }

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    _dio.options = await _getOptions();
    return _dio.get<T>(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
  }
}
