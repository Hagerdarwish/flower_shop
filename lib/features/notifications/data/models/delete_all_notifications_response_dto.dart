import 'package:json_annotation/json_annotation.dart';

part 'delete_all_notifications_response_dto.g.dart';

@JsonSerializable()
class DeleteAllNotificationsResponseDto {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "deletedCount")
  final int? deletedCount;

  DeleteAllNotificationsResponseDto({this.message, this.deletedCount});

  factory DeleteAllNotificationsResponseDto.fromJson(
    Map<String, dynamic> json,
  ) => _$DeleteAllNotificationsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DeleteAllNotificationsResponseDtoToJson(this);
}
