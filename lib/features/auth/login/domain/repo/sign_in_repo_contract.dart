

import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/request/sign_in_data_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/response/sign_in_response_entity.dart';

abstract interface class SignInRepoContract {
  Future<BaseResponse<SignInResponseEntity>> signIn({
    required SignInDataRequestEntity signInDataRequest,
  });
}
