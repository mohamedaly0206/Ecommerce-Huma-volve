abstract class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';

  //auth
  static const String login = '$baseUrl/auth/login';
  static const String signUp = '$baseUrl/users';
  //home
  static const String categories = '$baseUrl/categories';
  static const String products = '$baseUrl/products';
  static String categoryProducts(int categoryId) =>
      '$categories/$categoryId/products';
}
