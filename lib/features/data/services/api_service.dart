import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService() : dio =
    Dio(
      BaseOptions(baseUrl: "https://fakestoreapi.com"),
    ) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print("Request: ${options.uri}");
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print("Request: ${response.data}");
            return handler.next(response);
          },
          onError: (error, handler) {
            print("Error: ${error.message}");
            return handler.next(error);
          },
        ),
      );
    }
  
  Future<Response> getProducts() async {
    return await dio.get('/products');
  }
}