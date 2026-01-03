import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/e_commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/e_commerce/domain/repos/ecommerce_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllCategoriesUsecase {
  EcommerceRepo categoriesRepo;
  AllCategoriesUsecase(this.categoriesRepo);

  Future<ApiResult<AllCategoriesModel>> call() =>
      categoriesRepo.getAllCategories();
}
