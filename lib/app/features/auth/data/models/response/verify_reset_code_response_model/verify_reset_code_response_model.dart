import 'package:json_annotation/json_annotation.dart';
part 'verify_reset_code_response_model.g.dart';
@JsonSerializable()
class VerifyResetCodeResponse {
  final String status;

  VerifyResetCodeResponse({required this.status});

  factory VerifyResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifyResetCodeResponseToJson(this);
}
