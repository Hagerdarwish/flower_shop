import 'package:json_annotation/json_annotation.dart';
part 'changePassrequest.g.dart';

@JsonSerializable()
class ChangePassRequest {
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "newPassword")
  String? newPassword;

  ChangePassRequest({this.password, this.newPassword});

  factory ChangePassRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePassRequestToJson(this);
}
