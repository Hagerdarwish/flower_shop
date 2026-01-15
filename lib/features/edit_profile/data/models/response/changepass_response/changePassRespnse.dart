import 'package:json_annotation/json_annotation.dart';
part 'changePassRespnse.g.dart';

@JsonSerializable()
class ChangePassResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "token")
  String? token;

  ChangePassResponse({this.message, this.token});

  factory ChangePassResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePassResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePassResponseToJson(this);
}
