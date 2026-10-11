
import 'package:ecommerce_app_huma_volve/core/routes/app_routes.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/screens/login_screen.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      // case AppRoutes.forgetPasswordScreen:
      //   return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
