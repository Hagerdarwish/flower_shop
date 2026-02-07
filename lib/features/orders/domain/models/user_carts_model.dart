class UserCartsModel {
  final String? message;
  final String? error;
  final int? numOfCartItems;
  final CartModel? cart;

  UserCartsModel({this.message, this.error, this.numOfCartItems, this.cart});
}

class CartModel {
  final String? id;
  final String? user;
  final List<CartItemsModel?>? cartItems;
  final List<dynamic>? appliedCoupons;
  final int? totalPrice;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  CartModel({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}

class CartItemsModel {
  final ProductCartModel? product;
  final int? price;
  final int? quantity;
  final String? id;

  CartItemsModel({this.product, this.price, this.quantity, this.id});
}

class ProductCartModel {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String?>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? isSuperAdmin;
  final int? sold;
  final int? rateAvg;
  final int? rateCount;
  final String? idString;

  ProductCartModel({
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
}
