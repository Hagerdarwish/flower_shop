
import 'package:json_annotation/json_annotation.dart';
part 'forget_password_response_model.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  final String message;
  final String info;
  ForgotPasswordResponse({
    required this.message,
    required this.info,});
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ForgotPasswordResponseToJson(this);}
