import 'package:flower_shop/features/home/presentation/manager/factory/home_factory_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_categories_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_occasions_usecase.dart';
import 'package:flower_shop/features/home/domain/usecase/get_products_usecase.dart';
import 'home_factory_imp_test.mocks.dart';


@GenerateMocks([
  GetProductsUseCase,
  GetCategoriesUseCase,
  GetBestSellerUseCase,
  GetOccasionsUseCase
])
void main() {
  late MockGetProductsUseCase mockProducts;
  late MockGetCategoriesUseCase mockCategories;
  late MockGetBestSellerUseCase mockBestSeller;
  late MockGetOccasionsUseCase mockOccasions;

  late RemoteHomeFactory factory;

  setUp(() {
    mockProducts = MockGetProductsUseCase();
    mockCategories = MockGetCategoriesUseCase();
    mockBestSeller = MockGetBestSellerUseCase();
    mockOccasions = MockGetOccasionsUseCase();

    factory = RemoteHomeFactory(
      mockProducts,
      mockCategories,
      mockBestSeller,
      mockOccasions,
    );
  });

  test('should return the correct instances from factory', () {
    expect(factory.products(), mockProducts);
    expect(factory.categories(), mockCategories);
    expect(factory.bestSeller(), mockBestSeller);
    expect(factory.occasions(), mockOccasions);
  });
}
