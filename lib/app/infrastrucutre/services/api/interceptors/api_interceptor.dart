import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiInterceptor extends Interceptor {

  ApiInterceptor() : super();

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // debugPrint('requesting ${options.uri}');
    return handler.next(options);
  }

  @override
  void onResponse(
      dynamic response,
      ResponseInterceptorHandler handler,
      ) async {
    // debugPrint("response for ${response.requestOptions.path}:: $response");
    if(response is Response) {
      return handler.next(response);
    }

    final success = response != null && response != false;

    if (success) return handler.next(response);

    //Reject all error codes from server except 402 and 200 OK
    return handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        response: response,
      ),
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('api error ${err.message}');
    return handler.next(err);
  }
}