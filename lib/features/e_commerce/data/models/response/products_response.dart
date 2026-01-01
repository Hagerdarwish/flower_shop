import 'package:flower_shop/features/e_commerce/data/models/response/remote_product.dart';

import 'meta_data.dart';

class ProductsResponse {
  final String? message;
  final Metadata? metadata;
  final List<RemoteProduct>? products;

  ProductsResponse({this.message, this.metadata, this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] != null
          ? Metadata.fromJson(json['metadata'])
          : null,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => RemoteProduct.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'metadata': metadata?.toJson(),
      'products': products?.map((e) => e.toJson()).toList(),
    };
  }
}
