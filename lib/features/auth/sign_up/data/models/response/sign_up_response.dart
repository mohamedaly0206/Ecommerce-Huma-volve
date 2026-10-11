import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/response/sign_up_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "email")
    final String? email;
    @JsonKey(name: "password")
    final String? password;
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "role")
    final String? role;
    @JsonKey(name: "avatar")
    final String? avatar;
    @JsonKey(name: "creationAt")
    final DateTime? creationAt;
    @JsonKey(name: "updatedAt")
    final DateTime? updatedAt;

    SignUpResponse({
        this.id,
        this.email,
        this.password,
        this.name,
        this.role,
        this.avatar,
        this.creationAt,
        this.updatedAt,
    });

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);

    Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
    SignUpResponseEntity toDomain() {
      return SignUpResponseEntity(
        id: id,
        email: email,
        name: name,
        role: role,
        avatar: avatar,
      );
    }
}
