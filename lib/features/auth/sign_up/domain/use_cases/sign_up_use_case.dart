import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/request/sign_up_data_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/response/sign_up_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/repo/sign_up_repo_contract.dart';
import 'package:injectable/injectable.dart';


@injectable
class SignUpUseCase {
  final SignUpRepoContract _signUpRepoContract;

  SignUpUseCase(this._signUpRepoContract);

  Future<BaseResponse<SignUpResponseEntity>> call({
    required SignUpDataRequestEntity signUpDataRequest,
  }) => _signUpRepoContract.signUp(signUpDataRequest: signUpDataRequest);
}
