
import '../../../../../app/core/network/api_result.dart';
import '../../../domain/product_details/models/product_details_entity.dart';
import '../../../domain/product_details/repos/product_details_repo.dart';
import '../datasource/product_details_remote_datasource.dart';
import 'package:injectable/injectable.dart';

import '../models/response/product_details_response.dart';
@LazySingleton(as: ProductDetailsRepo)
class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepoImpl(this.remoteDataSource);

  @override
  Future<ApiResult<ProductDetailsEntity>> getProductDetails(
      String productId) async {
    final result = await remoteDataSource.getProductDetails(productId);

    if (result is SuccessApiResult<ProductDetailsResponse>) {
      final product = result.data.product;

      return SuccessApiResult(
        data: ProductDetailsEntity(
          id: product.id,
          title: product.title,
          description: product.description,
          imgCover: product.imgCover,
          images: product.images,
          price: product.price,
          priceAfterDiscount: product.priceAfterDiscount,
          isInWishlist: product.isInWishlist,
          favoriteId: product.favoriteId, // Pass null if it's null
          isSuperAdmin: product.isSuperAdmin,
        ),
      );
    }

    if (result is ErrorApiResult<ProductDetailsResponse>) {
      return ErrorApiResult<ProductDetailsEntity>(
        error: result.error,
      );
    }

    return ErrorApiResult<ProductDetailsEntity>(
      error: 'Unexpected error',
    );
  }
}

