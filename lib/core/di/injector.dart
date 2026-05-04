import 'package:get_it/get_it.dart';
import '../../features/domain/services/splash_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => SplashService());
}