import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiService {
  final Dio dio;
  final Logger logger = Logger();

  ApiService() : dio =
    Dio(
      BaseOptions(baseUrl: "https://fakestoreapi.com"),
    ) {
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            logger.i("Request: ${options.uri}");
            return handler.next(options);
          },
          onResponse: (response, handler) {
            logger.d("Request: ${response.data}");
            return handler.next(response);
          },
          onError: (error, handler) {
            logger.e("Error: ${error.message}");
            return handler.next(error);
          },
        ),
      );
    }
  
  Future<Response> getProducts() async {
    return await dio.get('/products');
  }
}