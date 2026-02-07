import 'package:json_annotation/json_annotation.dart';

part 'logout_response_model.g.dart';

@JsonSerializable()
class LogoutResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "error")
  final String? error;

  LogoutResponse({this.message, this.error});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return _$LogoutResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LogoutResponseToJson(this);
  }
}
