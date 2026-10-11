import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/request/sign_up_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/response/sign_up_response.dart';


abstract interface class SignUpRemoteDataSourceContract {
  Future<BaseResponse<SignUpResponse>> signUp({
    required SignUpRequest signUpDataRequest,
  });
}
