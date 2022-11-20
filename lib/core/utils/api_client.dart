import 'package:dio/dio.dart';

///A class that exposes only status code and data returned from the Client's
/// requests
class ApiData<T> {
  final T data;
  final int? statusCode;

  const ApiData(this.data, this.statusCode);
}

///A wrapper class for the [Client] class
class ApiClient {
  ApiClient(String baseUrl) : _client = Dio(BaseOptions(baseUrl: baseUrl));

  final Dio _client;

  Future<ApiData<T>> get<T>(
    String subPath, {
    Map<String, dynamic>? parameters,
  }) {
    return _client
        .get(subPath, queryParameters: parameters)
        .then((result) => ApiData<T>(result.data as T, result.statusCode));
  }

  Future<ApiData<T>> post<T>(String subPath, {dynamic body}) {
    return _client
        .post(subPath, data: body)
        .then((result) => ApiData<T>(result.data as T, result.statusCode));
  }
}
