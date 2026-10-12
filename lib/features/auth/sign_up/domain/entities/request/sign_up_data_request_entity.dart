import 'package:equatable/equatable.dart';

class SignUpDataRequestEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String? role;
  final String? avatar;

  const SignUpDataRequestEntity({
    required this.name,
    required this.email,
    required this.password,
     this.role="customer",
     this.avatar="https://api.lorem.space/image/face?w=640&h=480", 
  });

  @override
  List<Object?> get props => [name, email, password, role, avatar];
}
