import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/sign_up_remote_data_source_contract.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/request/sign_up_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/response/sign_up_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/request/sign_up_data_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/response/sign_up_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repo/sign_up_repo_contract.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: SignUpRepoContract)
class SignUpRepoImp implements SignUpRepoContract {
  final SignUpRemoteDataSourceContract _signUpRemoteDataSourceImp;

  SignUpRepoImp(this._signUpRemoteDataSourceImp);

  @override
  Future<BaseResponse<SignUpResponseEntity>> signUp({
    required SignUpDataRequestEntity signUpDataRequest,
  }) async {
    final response = await _signUpRemoteDataSourceImp.signUp(
      signUpDataRequest: SignUpRequest.fromDomain(signUpDataRequest),
    );

    switch (response) {
      case SuccessBaseResponse<SignUpResponse> successResponse:
        return SuccessBaseResponse<SignUpResponseEntity>(
          data: successResponse.data.toDomain(),
        );

      case ErrorBaseResponse<SignUpResponse> errorResponse:
        return ErrorBaseResponse<SignUpResponseEntity>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
