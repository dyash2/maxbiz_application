import 'package:dio/dio.dart';

class ApiClient {
  Dio getDio() {
    Dio dio = Dio();
    dio.options.baseUrl = "https://maxone.m-square.tech";
    return dio;
  }
}
