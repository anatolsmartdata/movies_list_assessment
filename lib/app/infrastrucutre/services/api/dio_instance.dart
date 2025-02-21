import 'package:dio/dio.dart';
import 'interceptors/interceptors.dart';

class DioInstance {

  static final String apiKey = 'd313964';

  static String baseUrl(String apiKey) =>
  'http://www.omdbapi.com/?apikey=$apiKey';

  static final List<Interceptor> interceptors = [
    // LogInterceptor(),
    ApiInterceptor()
  ];

  final Dio request = Dio(
    BaseOptions(
      baseUrl: baseUrl(apiKey),
      validateStatus: (int? status) => true,
      contentType: 'application/json',
    )
  )..interceptors.addAll(interceptors);
}