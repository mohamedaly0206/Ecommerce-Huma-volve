import 'package:ecommerce_app_huma_volve/config/base_state/base_state.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/response/sign_in_response_entity.dart';
import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final BaseState<SignInResponseEntity> signInState;
  final bool rememberMe;

  const SignInState({
    this.signInState = const BaseState<SignInResponseEntity>(),
    this.rememberMe = false,
  });

  SignInState copyWith({
    BaseState<SignInResponseEntity>? signInState,
    bool? rememberMe,
  }) {
    return SignInState(
      signInState: signInState ?? this.signInState,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object> get props => [signInState, rememberMe];
}
