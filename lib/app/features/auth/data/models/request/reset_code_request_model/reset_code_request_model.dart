import 'package:json_annotation/json_annotation.dart';

part 'reset_code_request_model.g.dart';

@JsonSerializable()
class ResetCodeRequest {
  final String resetCode;

  ResetCodeRequest({required this.resetCode});

  factory ResetCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetCodeRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ResetCodeRequestToJson(this);
}
