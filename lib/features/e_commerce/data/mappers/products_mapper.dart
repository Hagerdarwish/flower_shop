import '../../domain/models/product_model.dart';
import '../models/response/remote_product.dart';

extension RemotProductExtention on RemoteProduct {
  ProductModel toProduct() {
    return ProductModel(
      id: id ?? "",
      name: title ?? "",
      oldPrice: price?.toDouble(),
      imageUrl: imgCover ?? "",
      price: priceAfterDiscount?.toDouble() ?? 0.0,
    );
  }
}
