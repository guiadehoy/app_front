import "package:dio/dio.dart";

class Client {
  Dio init() {
    Dio _dio = new Dio();
    _dio.options.baseUrl = "https://backoffice-api.dev.guiadehoy.com/api/v1";
    return _dio;
  }
}
