import 'package:json_annotation/json_annotation.dart';

part 'change-password-request-model.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  final String password;
  final String newPassword;

  const ChangePasswordRequest({
    required this.password,
    required this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
