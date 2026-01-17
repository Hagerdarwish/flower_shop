import 'package:json_annotation/json_annotation.dart';

part 'user_carts_dto.g.dart';

@JsonSerializable()
class UserCartsDto {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'error')
  final String? error;
  @JsonKey(name: 'numOfCartItems')
  final int? numOfCartItems;
  @JsonKey(name: 'cart')
  final CartDto? cart;

  UserCartsDto({this.message, this.error, this.numOfCartItems, this.cart});

  factory UserCartsDto.fromJson(Map<String, dynamic> json) =>
      _$UserCartsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserCartsDtoToJson(this);
}

@JsonSerializable()
class CartDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'cartItems')
  final List<CartItemsDto?>? cartItems;
  @JsonKey(name: 'appliedCoupons')
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: 'totalPrice')
  final int? totalPrice;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  CartDto({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}

@JsonSerializable()
class CartItemsDto {
  @JsonKey(name: 'product')
  final ProductCartDto? product;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  CartItemsDto({this.product, this.price, this.quantity, this.id});

  factory CartItemsDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemsDtoToJson(this);
}

@JsonSerializable()
class ProductCartDto {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imgCover')
  final String? imgCover;
  @JsonKey(name: 'images')
  final List<String?>? images;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'priceAfterDiscount')
  final int? priceAfterDiscount;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'occasion')
  final String? occasion;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;
  @JsonKey(name: 'sold')
  final int? sold;
  @JsonKey(name: 'rateAvg')
  final int? rateAvg;
  @JsonKey(name: 'rateCount')
  final int? rateCount;
  @JsonKey(name: 'id')
  final String? idString;

  ProductCartDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
    this.idString,
  });

  factory ProductCartDto.fromJson(Map<String, dynamic> json) =>
      _$ProductCartDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCartDtoToJson(this);
}
