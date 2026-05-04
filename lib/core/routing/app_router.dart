import 'package:go_router/go_router.dart';
import '../../features/presentation/pages/splash_page.dart';
import '../../features/presentation/pages/product_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder:(context, state) => const SplashPage(),
    ),

    GoRoute(
      path: '/product',
      builder: (context, state) => const ProductPage(),
    ),
  ],
);