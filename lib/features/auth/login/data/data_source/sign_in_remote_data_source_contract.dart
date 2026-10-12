import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/request/sign_in_data_request_dto.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/response/sign_in_response_dto.dart';

abstract interface class SignInRemoteDataSourceContract {
  Future<BaseResponse<SignInResponseDto>> signIn({
    required SignInDataRequestDto signInDataRequest,
  });
}
