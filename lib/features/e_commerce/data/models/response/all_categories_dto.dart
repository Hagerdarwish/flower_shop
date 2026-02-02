import 'package:json_annotation/json_annotation.dart';

part 'all_categories_dto.g.dart';

@JsonSerializable()
class AllCategoriesDto {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final MetadataDto? metadata;
  @JsonKey(name: 'categories')
  final List<CategoryItemDto?>? categories;

  AllCategoriesDto({this.message, this.metadata, this.categories});

  factory AllCategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$AllCategoriesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AllCategoriesDtoToJson(this);
}

@JsonSerializable()
class CategoryItemDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;
  @JsonKey(name: 'productsCount')
  final int? productsCount;

  CategoryItemDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,
    this.productsCount,
  });

  factory CategoryItemDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryItemDtoToJson(this);
}

@JsonSerializable()
class MetadataDto {
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'totalItems')
  final int? totalItems;

  MetadataDto({this.currentPage, this.limit, this.totalPages, this.totalItems});

  factory MetadataDto.fromJson(Map<String, dynamic> json) =>
      _$MetadataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataDtoToJson(this);
}
