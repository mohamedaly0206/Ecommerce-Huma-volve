import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failures.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/api_client/sign_in_api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/sign_in_remote_data_source_contract.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/request/sign_in_data_request_dto.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/response/sign_in_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignInRemoteDataSourceContract)
class SignInRemoteDataSourceImp implements SignInRemoteDataSourceContract {
  final SignInApiClient _signInApiClient;
  SignInRemoteDataSourceImp(this._signInApiClient);
  @override
  Future<BaseResponse<SignInResponseDto>> signIn({
    required SignInDataRequestDto signInDataRequest,
  }) async {
    try {
      final response = await _signInApiClient.signIn(signInDataRequest);
      return SuccessBaseResponse<SignInResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<SignInResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
