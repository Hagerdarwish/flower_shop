// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imgCover: json['imgCover'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      price: (json['price'] as num).toInt(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num).toInt(),
      isInWishlist: json['isInWishlist'] as bool,
      favoriteId: json['favoriteId'] as String?,
      isSuperAdmin: json['isSuperAdmin'] as bool?,
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
  ProductDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imgCover': instance.imgCover,
  'images': instance.images,
  'price': instance.price,
  'priceAfterDiscount': instance.priceAfterDiscount,
  'isInWishlist': instance.isInWishlist,
  'favoriteId': instance.favoriteId,
  'isSuperAdmin': instance.isSuperAdmin,
};
