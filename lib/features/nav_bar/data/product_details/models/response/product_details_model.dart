import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/product_details/models/product_details_entity.dart';
part 'product_details_model.g.dart';
@JsonSerializable()
class ProductDetailsModel extends ProductDetailsEntity {
  ProductDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imgCover,
    required super.images,
    required super.price,
    required super.priceAfterDiscount,
    required super.isInWishlist,
    super.favoriteId,
    super.isSuperAdmin,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imgCover: json['imgCover'] as String,
      images: List<String>.from(json['images'] as List),
      price: json['price'] as int,
      priceAfterDiscount: json['priceAfterDiscount'] as int,
      isInWishlist: json['isInWishlist'] as bool? ?? false,
      favoriteId: json['favoriteId'] as String?,
      isSuperAdmin: json['isSuperAdmin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'description': description,
    'imgCover': imgCover,
    'images': images,
    'price': price,
    'priceAfterDiscount': priceAfterDiscount,
    'isInWishlist': isInWishlist,
    'favoriteId': favoriteId,
    'isSuperAdmin': isSuperAdmin,
  };

  ProductDetailsEntity toEntity() => this;
}