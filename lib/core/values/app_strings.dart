abstract class AppStrings {
  static const String appName = 'Shopora';

  //auth
  static const String login = 'Login';
  static const String noToken = 'noToken';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  static const String token = 'token';

  //storage errors
  static const String storeCacheExceptionMessage =
      'failed to store data locally, please try again later';
  static const String getCacheExceptionMessage =
      'failed to get data locally, please try again later';
  static const String cacheStorageError = "Storage Error";

  //server failure messages
  static const String errorMessage =
      'Something went wrong, please try again later';
  static const String serverConnTimeout = 'Connection timeout with API server';
  static const String serverSendTimeout = 'Send timeout with API server';
  static const String serverRecTimeout = 'Receive timeout with API server';
  static const String serverCertError = 'Bad certificate with API server';
  static const String serverCancel = 'Request to API server was cancelled';
  static const String serverConnError = 'There is Connection Error';
  static const String serverNoInternet = 'No Internet Connection';
  static const String serverInvalidCreds = 'Invalid email or password';
  static const String serverNotFound =
      'Opps there was an error, please try again';
  static const String serverInternalError =
      'Internal server error, please try again later';
  static const String serverDefaultError =
      'Opps there was an error, please try again';
  static const String userIdNotFound = 'User not found, please login again';
}
