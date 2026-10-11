import 'package:equatable/equatable.dart';

class SignInDataRequestEntity extends Equatable {
  final String email;
  final String password;

  const SignInDataRequestEntity({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
