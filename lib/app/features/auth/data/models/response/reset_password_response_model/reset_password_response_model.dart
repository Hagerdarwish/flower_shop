import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/reset_password_entity.dart';

part 'reset_password_response_model.g.dart';
@JsonSerializable()
class ResetPasswordResponse {
  final String message;
  final String? token;
  final int? code;

  ResetPasswordResponse({
    required this.message,
    this.token,
    this.code,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);

  ResetPasswordEntity toEntity() => ResetPasswordEntity(
    message: message,
    token: token,
    code: code,
  );
}