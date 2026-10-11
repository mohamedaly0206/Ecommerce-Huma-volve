import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/values/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/request/sign_up_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/response/sign_up_response.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class SignUpApiClient {
  final Dio _dio;

  SignUpApiClient(this._dio);

  Future<SignUpResponse> signUp(SignUpRequest signUpDataRequest) async {
    final response = await _dio.post(
      ApiEndpoints.signUp,
      data: signUpDataRequest.toJson(),
    );

    return SignUpResponse.fromJson(response.data);
  }
}
