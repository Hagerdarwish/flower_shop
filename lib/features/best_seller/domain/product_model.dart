class ProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? oldPrice;
  final int? discountPercent;
  final bool isBestSeller;

  const ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.discountPercent,
    required this.isBestSeller,
  });
}
