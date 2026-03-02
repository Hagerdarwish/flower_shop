import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/change_password_entity.dart';

part 'change-password-response-model.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  final String message;
  final String? token;

  ChangePasswordResponse({required this.message, this.token});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);

  ChangePasswordEntity toEntity() =>
      ChangePasswordEntity(message: message, token: token);
}
