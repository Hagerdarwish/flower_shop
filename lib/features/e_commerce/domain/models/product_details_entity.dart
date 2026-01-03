class ProductDetailsEntity {
  final String id;
  final String title;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final bool isInWishlist;
  final String? favoriteId; // Keep it nullable
  final bool? isSuperAdmin;

  ProductDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.isInWishlist,
    this.favoriteId, // Remove default value
    this.isSuperAdmin,
  });
}
