import 'package:get_it/get_it.dart';
import 'package:utd_store/features/data/models/product_repo.dart';
import '../../features/domain/services/splash_service.dart';
import '../../features/data/services/api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => SplashService());
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => ProductRepo());
}