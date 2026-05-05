import 'package:go_router/go_router.dart';
import 'package:utd_store/features/presentation/pages/bookmark_page.dart';
import 'package:utd_store/features/presentation/pages/detail_page.dart';
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

    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        return DetailPage(productId: productId);
      },
    ),

    GoRoute(
      path: '/bookmark',
      builder: (context, state) => BookmarkPage(),
    ),
  ],
);