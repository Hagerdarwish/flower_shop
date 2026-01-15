import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_cubit.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_state.dart';
import 'package:flower_shop/features/best_seller/menager/best_seller_intent.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/usecase/get_best_seller_usecase.dart';

// Simple manual mock
class TestGetBestSellerUseCase implements GetBestSellerUseCase {
  final ApiResult<List<BestSellerModel>> result;

  TestGetBestSellerUseCase(this.result);

  @override
  Future<ApiResult<List<BestSellerModel>>> call() async => result;
}

void main() {
  final productsList = [
    BestSellerModel(id: '1', title: 'Product 1', price: 100, imgCover: ''),
    BestSellerModel(id: '2', title: 'Product 2', price: 200, imgCover: ''),
  ];

  group('BestSellerCubit', () {
    test('initial state should have initial status', () {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: []),
      );
      final cubit = BestSellerCubit(useCase);

      expect(cubit.state.products.status, Status.initial);
      expect(cubit.state.products.data, isNull);
      expect(cubit.state.selectedIndex, 0);
    });

    test('should emit loading then success when usecase succeeds', () async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: productsList),
      );
      final cubit = BestSellerCubit(useCase);

      final states = <BestSellerState>[];
      final subscription = cubit.stream.listen(states.add);

      cubit.doIntent(LoadBestSellersEvent());
      await Future.delayed(Duration.zero);
      await subscription.cancel();

      expect(states.length, 2);
      expect(states[0].products.status, Status.loading);
      expect(states[1].products.status, Status.success);
      expect(states[1].products.data, productsList);
    });

    test('should emit loading then error when usecase fails', () async {
      final useCase = TestGetBestSellerUseCase(
        ErrorApiResult<List<BestSellerModel>>(error: 'Network error'),
      );
      final cubit = BestSellerCubit(useCase);

      final states = <BestSellerState>[];
      final subscription = cubit.stream.listen(states.add);

      cubit.doIntent(LoadBestSellersEvent());
      await Future.delayed(Duration.zero);
      await subscription.cancel();

      expect(states.length, 2);
      expect(states[0].products.status, Status.loading);
      expect(states[1].products.status, Status.error);
      expect(states[1].products.error, 'Network error');
    });

    test('should handle empty product list', () async {
      final useCase = TestGetBestSellerUseCase(
        SuccessApiResult<List<BestSellerModel>>(data: []),
      );
      final cubit = BestSellerCubit(useCase);

      final states = <BestSellerState>[];
      final subscription = cubit.stream.listen(states.add);

      cubit.doIntent(LoadBestSellersEvent());
      await Future.delayed(Duration.zero);
      await subscription.cancel();

      expect(states.length, 2);
      expect(states[1].products.status, Status.success);
      expect(states[1].products.data, isEmpty);
    });
  });
}
