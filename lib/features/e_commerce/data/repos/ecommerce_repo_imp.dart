import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/product_details_response.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/e_commerce/data/mappers/all_categories_mapper.dart';
import 'package:flower_shop/features/e_commerce/data/mappers/products_mapper.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/all_categories_dto.dart';
import 'package:flower_shop/features/e_commerce/domain/models/product_details_entity.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repos/ecommerce_repo.dart';
import '../datasource/ecommerce_remote_datasource.dart';
import '../models/response/products_response.dart';

@Injectable(as: EcommerceRepo)
class EcommerceRepoImp implements EcommerceRepo {
  final EcommerceRemoteDatasource datasource;

  EcommerceRepoImp(this.datasource);

  @override
  Future<ApiResult<List<ProductModel>>> getProducts({
    String? occasion,
    String? category,
  }) async {
    final result = await datasource.getProduct(
      occasion: occasion,
      category: category,
    );
    switch (result) {
      case SuccessApiResult<ProductsResponse>():
        return SuccessApiResult(
          data: result.data.products!.map((remoteProduct) {
            return remoteProduct.toProduct();
          }).toList(),
        );
      case ErrorApiResult<ProductsResponse>():
        return ErrorApiResult(error: result.error);
    }
  }

  @override
  Future<ApiResult<AllCategoriesModel>> getAllCategories() async {
    final result = await datasource.getAllCategories();
    switch (result) {
      case SuccessApiResult<AllCategoriesDto>():
        AllCategoriesDto dto = result.data;
        AllCategoriesModel allCategoriesModel = dto.toAllCategoriesModel();
        return SuccessApiResult<AllCategoriesModel>(data: allCategoriesModel);
      case ErrorApiResult<AllCategoriesDto>():
        return ErrorApiResult<AllCategoriesModel>(error: result.error);
    }
  }

  @override
  Future<ApiResult<ProductDetailsEntity>> getProductDetails(
    String productId,
  ) async {
    final result = await datasource.getProductDetails(productId);

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
      return ErrorApiResult<ProductDetailsEntity>(error: result.error);
    }

    return ErrorApiResult<ProductDetailsEntity>(error: 'Unexpected error');
  }
}
