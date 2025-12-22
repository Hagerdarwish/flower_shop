import 'package:json_annotation/json_annotation.dart';
part 'reset_code_response_model.g.dart';
@JsonSerializable()
class ResetCodeResponse {
  final String status;

  ResetCodeResponse({required this.status});

  factory ResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetCodeResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ResetCodeResponseToJson(this);
}
