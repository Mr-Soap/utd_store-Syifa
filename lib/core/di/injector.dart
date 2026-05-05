import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:utd_store/features/data/models/repositories/bookmark_repo.dart';
import 'package:utd_store/features/data/models/repositories/product_repo.dart';
import 'package:utd_store/features/domain/services/crypto_service.dart';
import 'package:utd_store/features/domain/services/native_service.dart';
import '../../features/domain/services/splash_service.dart';
import '../../features/data/services/api_service.dart';
import '../../features/data/services/product_service.dart';
import '../../features/data/models/bookmark_model.dart';

final sl = GetIt.instance;

late Isar isar;

Future<void> init() async {
  final dir = await getApplicationDocumentsDirectory();

  isar = await Isar.open(
    [BookmarkSchema],
    directory: dir.path,
  );

  sl.registerLazySingleton(() => isar);
  sl.registerLazySingleton(() => SplashService());
  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => ProductRepo());
  sl.registerLazySingleton(() => BookmarkRepo());
  sl.registerLazySingleton(() => CryptoService());
  sl.registerLazySingleton(() => NativeService());
  sl.registerFactory(() => ProductService(sl()));
}