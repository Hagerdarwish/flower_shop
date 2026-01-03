// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_categories_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCategoriesDto _$AllCategoriesDtoFromJson(Map<String, dynamic> json) =>
    AllCategoriesDto(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
          ?.map(
            (e) => e == null
                ? null
                : CategoryItemDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$AllCategoriesDtoToJson(AllCategoriesDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'categories': instance.categories,
    };

CategoryItemDto _$CategoryItemDtoFromJson(Map<String, dynamic> json) =>
    CategoryItemDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isSuperAdmin: json['isSuperAdmin'] as bool?,
      productsCount: (json['productsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryItemDtoToJson(CategoryItemDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isSuperAdmin': instance.isSuperAdmin,
      'productsCount': instance.productsCount,
    };

MetadataDto _$MetadataDtoFromJson(Map<String, dynamic> json) => MetadataDto(
  currentPage: (json['currentPage'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
  totalItems: (json['totalItems'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetadataDtoToJson(MetadataDto instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
    };
