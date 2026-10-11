import 'package:equatable/equatable.dart';

class SignInResponseEntity extends Equatable {
 
  final String? accessToken;
  final String? refreshToken;
  const SignInResponseEntity({ this.accessToken, this.refreshToken});
  @override
  List<Object?> get props => [accessToken, refreshToken];
}
