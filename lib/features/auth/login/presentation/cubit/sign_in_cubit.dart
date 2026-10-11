import 'package:ecommerce_app_huma_volve/config/base_response/base_response.dart';
import 'package:ecommerce_app_huma_volve/config/base_state/base_state.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/request/sign_in_data_request_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/response/sign_in_response_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/sign_in_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/cubit/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase _signInUseCase;

  SignInCubit(this._signInUseCase) : super(const SignInState());

  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  Future<void> signIn({
    required SignInDataRequestEntity signInDataRequest,
  }) async {
    emit(state.copyWith(signInState: const BaseState(isLoading: true)));
    final response = await _signInUseCase.call(
      signInDataRequest: signInDataRequest,
    );
    if (response is SuccessBaseResponse<SignInResponseEntity>) {
      emit(
        state.copyWith(
          signInState: BaseState(isLoading: false, data: response.data),
        ),
      );
    } else if (response is ErrorBaseResponse<SignInResponseEntity>) {
      emit(
        state.copyWith(
          signInState: BaseState(
            isLoading: false,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }
}
