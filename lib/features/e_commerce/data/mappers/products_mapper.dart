import 'package:flower_shop/features/home/domain/models/product_model.dart';
import '../models/response/remote_product.dart';

extension RemotProductExtention on RemoteProduct {
  ProductModel toProduct() {
    return ProductModel(
      id: id ?? "",
      title: title ?? "",
      price: price?.toInt(),
      imgCover: imgCover ?? "",
      priceAfterDiscount: priceAfterDiscount?.toInt(),
    );
  }
}
