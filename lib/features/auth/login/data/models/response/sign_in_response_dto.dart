import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/response/sign_in_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'sign_in_response_dto.g.dart';

SignInResponseDto signInResponseDtoFromJson(String str) => SignInResponseDto.fromJson(json.decode(str));

String signInResponseDtoToJson(SignInResponseDto data) => json.encode(data.toJson());

@JsonSerializable()
class SignInResponseDto {
    @JsonKey(name: "access_token")
    final String? accessToken;
    @JsonKey(name: "refresh_token")
    final String? refreshToken;

    SignInResponseDto({
        this.accessToken,
        this.refreshToken,
    });

    factory SignInResponseDto.fromJson(Map<String, dynamic> json) => _$SignInResponseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$SignInResponseDtoToJson(this);
    SignInResponseEntity toDomain() {
      return SignInResponseEntity(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }

}
