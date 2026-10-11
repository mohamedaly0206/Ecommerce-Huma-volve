import 'package:ecommerce_app_huma_volve/config/di/di.dart';
import 'package:ecommerce_app_huma_volve/core/routes/app_routers.dart';
import 'package:ecommerce_app_huma_volve/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRouters.generateRoute,
    );
  }
}
