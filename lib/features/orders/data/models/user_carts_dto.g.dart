// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_carts_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCartsDto _$UserCartsDtoFromJson(Map<String, dynamic> json) => UserCartsDto(
  message: json['message'] as String?,
  error: json['error'] as String?,
  numOfCartItems: (json['numOfCartItems'] as num?)?.toInt(),
  cart: json['cart'] == null
      ? null
      : CartDto.fromJson(json['cart'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserCartsDtoToJson(UserCartsDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'numOfCartItems': instance.numOfCartItems,
      'cart': instance.cart,
    };

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
  id: json['_id'] as String?,
  user: json['user'] as String?,
  cartItems: (json['cartItems'] as List<dynamic>?)
      ?.map(
        (e) =>
            e == null ? null : CartItemsDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  appliedCoupons: json['appliedCoupons'] as List<dynamic>?,
  totalPrice: (json['totalPrice'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
  '_id': instance.id,
  'user': instance.user,
  'cartItems': instance.cartItems,
  'appliedCoupons': instance.appliedCoupons,
  'totalPrice': instance.totalPrice,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
};

CartItemsDto _$CartItemsDtoFromJson(Map<String, dynamic> json) => CartItemsDto(
  product: json['product'] == null
      ? null
      : Product.fromJson(json['product'] as Map<String, dynamic>),
  price: (json['price'] as num?)?.toInt(),
  quantity: (json['quantity'] as num?)?.toInt(),
  id: json['_id'] as String?,
);

Map<String, dynamic> _$CartItemsDtoToJson(CartItemsDto instance) =>
    <String, dynamic>{
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
      '_id': instance.id,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  slug: json['slug'] as String?,
  description: json['description'] as String?,
  imgCover: json['imgCover'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String?).toList(),
  price: (json['price'] as num?)?.toInt(),
  priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
  quantity: (json['quantity'] as num?)?.toInt(),
  category: json['category'] as String?,
  occasion: json['occasion'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
  isSuperAdmin: json['isSuperAdmin'] as bool?,
  sold: (json['sold'] as num?)?.toInt(),
  rateAvg: (json['rateAvg'] as num?)?.toInt(),
  rateCount: (json['rateCount'] as num?)?.toInt(),
  idString: json['id'] as String?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'description': instance.description,
  'imgCover': instance.imgCover,
  'images': instance.images,
  'price': instance.price,
  'priceAfterDiscount': instance.priceAfterDiscount,
  'quantity': instance.quantity,
  'category': instance.category,
  'occasion': instance.occasion,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
  'isSuperAdmin': instance.isSuperAdmin,
  'sold': instance.sold,
  'rateAvg': instance.rateAvg,
  'rateCount': instance.rateCount,
  'id': instance.idString,
};
