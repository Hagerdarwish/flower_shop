import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasion_model.g.dart';
@JsonSerializable()
class Occasion {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;

  Occasion({
    this.Id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) {
    return _$OccasionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OccasionToJson(this);
  }

    OccasionModel toEntity() {
    return OccasionModel(
      id: Id ?? '',
      name: name ?? '',
      slug: slug ?? '',
      image: image ?? '',
      createdAt:
          createdAt != null ? DateTime.tryParse(createdAt!) : null,
      updatedAt:
          updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      isSuperAdmin: isSuperAdmin ?? false,
      productsCount:null, 
    );
  }
}
