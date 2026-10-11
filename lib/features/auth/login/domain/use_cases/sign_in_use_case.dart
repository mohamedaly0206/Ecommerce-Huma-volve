import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/request/sign_in_data_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/response/sign_in_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repo/sign_in_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final SignInRepoContract _signInRepoContract;
  SignInUseCase(this._signInRepoContract);
  Future<BaseResponse<SignInResponseEntity>> call({
    required SignInDataRequestEntity signInDataRequest,
  }) => _signInRepoContract.signIn(signInDataRequest: signInDataRequest);
}
