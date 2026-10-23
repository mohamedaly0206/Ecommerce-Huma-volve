import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/di/di.dart';
import '../../core/dummy_data.dart';
import '../../core/routes/app_routes.dart';
import '../../features/auth/login/presentation/cubit/sign_in_cubit.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';
import '../../features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import '../../features/auth/sign_up/presentation/screens/sign_up_screen.dart';
import '../../features/details/screens/product_details_screen.dart';
import '../../features/main_navigation/screens/main_navigation_screen.dart';
import '../../features/splash/screens/splash_screen.dart';

abstract class AppRouters {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.signInScreen,
        pageBuilder: (context, state) => _fadeRoute(
          state: state,
          child: BlocProvider(
            create: (context) => getIt<SignInCubit>(),
            child: const LoginScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUpScreen,
        pageBuilder: (context, state) => _fadeRoute(
          state: state,
          child: BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.mainNavigationScreen,
        pageBuilder: (context, state) => _fadeRoute(
          state: state,
          child: const MainNavigationScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.productDetails,
        pageBuilder: (context, state) {
          final productId = state.pathParameters['id'] ?? '';
          final product = state.extra as Product?;
          return _fadeRoute(
            state: state,
            child: ProductDetailsScreen(
              productId: productId,
              product: product,
            ),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No route defined for ${state.uri.toString()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.mainNavigationScreen),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );

  static CustomTransitionPage<void> _fadeRoute({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}