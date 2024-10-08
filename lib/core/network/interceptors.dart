import 'dart:developer';

import 'package:dio/dio.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now();
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final statusCode = err.response?.statusCode;
    final requestPath = '${options.baseUrl}${options.path}';

    final startTime = options.extra['startTime'] as DateTime?;
    String timeTakenLog = '';
    if (startTime != null) {
      final timeTaken = DateTime.now().difference(startTime).inMilliseconds;
      timeTakenLog = ' in $timeTaken ms';
    }

    log('$requestPath = $statusCode$timeTakenLog', name: options.method);
    log('ERROR TYPE: ${err.error} \n ERROR MESSAGE: ${err.message}');
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestPath =
        '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    final startTime = response.requestOptions.extra['startTime'] as DateTime?;
    String timeTakenLog = '';
    if (startTime != null) {
      final timeTaken = DateTime.now().difference(startTime).inMilliseconds;
      timeTakenLog = ' in $timeTaken ms';
    }
    log('$requestPath = ${response.statusCode}$timeTakenLog',
        name: response.requestOptions.method);
    handler.next(response);
  }
}
