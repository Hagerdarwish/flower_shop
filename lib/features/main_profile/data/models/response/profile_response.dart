import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "ProfileUserModel")
  final ProfileUserModel? profileUserModel;

  ProfileResponse({required this.message, required this.profileUserModel});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  ProfileUserModel toDomain() {
    return ProfileUserModel(
      id: profileUserModel?.id ?? "",
      firstName: profileUserModel?.firstName ?? "",
      lastName: profileUserModel?.lastName ?? "",
      email: profileUserModel?.email ?? "",
    );
  }
}
