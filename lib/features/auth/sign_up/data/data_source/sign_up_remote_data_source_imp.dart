import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failures.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/api_client/sign_up_api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/sign_up_remote_data_source_contract.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/request/sign_up_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/response/sign_up_response.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: SignUpRemoteDataSourceContract)
class SignUpRemoteDataSourceImp implements SignUpRemoteDataSourceContract {
  final SignUpApiClient _signUpApiClient;

  SignUpRemoteDataSourceImp(this._signUpApiClient);

  @override
  Future<BaseResponse<SignUpResponse>> signUp({
    required SignUpRequest signUpDataRequest,
  }) async {
    try {
      final response = await _signUpApiClient.signUp(signUpDataRequest);
      return SuccessBaseResponse<SignUpResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<SignUpResponse>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
