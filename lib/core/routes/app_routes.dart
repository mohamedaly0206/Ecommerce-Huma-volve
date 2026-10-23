class AppRoutes {
  static const String productLinkHost = 'huma-volve-e-commerce.web.app';

  static const String splashScreen = '/';
  static const String mainNavigationScreen = '/main-navigation';
  static const String signInScreen = '/sign-in';
  static const String signUpScreen = '/sign-up';
  static const String productDetails = '/product/:id';

  static String productDetailsPath(String id) => '/product/$id';

  static Uri productShareUri(String id) =>
      Uri.https(productLinkHost, productDetailsPath(id));
}
