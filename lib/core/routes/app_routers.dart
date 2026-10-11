import 'package:ecommerce_app_huma_volve/config/di/di.dart';
import 'package:ecommerce_app_huma_volve/core/routes/app_routes.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/cubit/sign_in_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/screens/login_screen.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/screens/home_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        
      case AppRoutes.signInScreen:
        return _fadeRoute(
          BlocProvider(
            create: (context) => getIt<SignInCubit>(),
            child: const LoginScreen(),
          ),
        );
        
      case AppRoutes.signUpScreen:
        return _fadeRoute(
          BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
        
      case AppRoutes.homeScreen:
        return _fadeRoute(const HomeScreen());
        
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}