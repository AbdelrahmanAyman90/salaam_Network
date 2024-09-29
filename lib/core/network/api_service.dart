import 'package:dio/dio.dart';

//response for do api fun like get put post
class ApiServes {
  final Dio dio;

  ApiServes({required this.dio});

  Future<dynamic> get({
    required String link,
    Map<String, dynamic>? headerRequst,
  }) async {
    // do requst
    var response = await dio.get(link, options: Options(headers: headerRequst));
    return response.data; //contain a JSON object
  }
}

Dio creatdio() {
  Dio dio = Dio();

  dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseHeader: true));

  return dio;
}
