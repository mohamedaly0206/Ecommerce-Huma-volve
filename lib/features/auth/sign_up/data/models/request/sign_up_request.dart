import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/request/sign_up_data_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
    @JsonKey(name: "email")
    final String? email;
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "password")
    final String? password;
    @JsonKey(name: "role")
    final String? role;
    @JsonKey(name: "avatar")
    final String? avatar;

    SignUpRequest({
        this.email,
        this.name,
        this.password,
        this.role,
        this.avatar,
    });

    factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);

    Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
    factory SignUpRequest.fromDomain(SignUpDataRequestEntity entity) {
    return SignUpRequest(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      role: entity.role,
      avatar: entity.avatar,
    );
  }
}
