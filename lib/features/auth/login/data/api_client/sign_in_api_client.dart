import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/values/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/request/sign_in_data_request_dto.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/response/sign_in_response_dto.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class SignInApiClient {
  final Dio _dio;

  SignInApiClient(this._dio);

  Future<SignInResponseDto> signIn(
    SignInDataRequestDto signInDataRequest,
  ) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: signInDataRequest.toJson(),
    );

    return SignInResponseDto.fromJson(response.data);
  }
}
