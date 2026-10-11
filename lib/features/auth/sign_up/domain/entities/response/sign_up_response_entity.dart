import 'package:equatable/equatable.dart';

class SignUpResponseEntity extends Equatable {
  final int? id;
  final String? email;
  final String? name;
  final String? role;
  final String? avatar;

  const SignUpResponseEntity({
    this.id,
    this.email,
    this.name,
    this.role,
    this.avatar,
  });
  @override
  List<Object?> get props => [id, email, name, role, avatar];
}
