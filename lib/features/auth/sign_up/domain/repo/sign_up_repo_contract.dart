import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/request/sign_up_data_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/response/sign_up_response_entity.dart';

abstract interface class SignUpRepoContract {
  Future<BaseResponse<SignUpResponseEntity>> signUp({
    required SignUpDataRequestEntity signUpDataRequest,
  });
}
