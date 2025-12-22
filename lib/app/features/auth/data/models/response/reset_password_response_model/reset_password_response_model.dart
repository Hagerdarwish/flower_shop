import 'package:json_annotation/json_annotation.dart';
part 'reset_password_response_model.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "token")
  final String token;

  ResetPasswordResponse({
    required this.message,
    required this.token,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}
