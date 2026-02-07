class RemoteProduct {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? isSuperAdmin;
  final int? sold;
  final num? rateAvg;
  final int? rateCount;
  final String? favoriteId;
  final bool? isInWishlist;

  RemoteProduct({
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
    this.favoriteId,
    this.isInWishlist,
  });

  factory RemoteProduct.fromJson(Map<String, dynamic> json) {
    return RemoteProduct(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      imgCover: json['imgCover'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'] as num?,
      priceAfterDiscount: json['priceAfterDiscount'] as num?,
      quantity: json['quantity'] as int?,
      category: json['category'] as String?,
      occasion: json['occasion'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      isSuperAdmin: json['isSuperAdmin'] as bool?,
      sold: json['sold'] as int?,
      rateAvg: json['rateAvg'] as num?,
      rateCount: json['rateCount'] as int?,
      favoriteId: json['favoriteId'] as String?,
      isInWishlist: json['isInWishlist'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'imgCover': imgCover,
      'images': images,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'quantity': quantity,
      'category': category,
      'occasion': occasion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'isSuperAdmin': isSuperAdmin,
      'sold': sold,
      'rateAvg': rateAvg,
      'rateCount': rateCount,
      'favoriteId': favoriteId,
      'isInWishlist': isInWishlist,
    };
  }
}
