import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_orders_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_orders_usecases_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late GetOrdersUsecases usecase;
  late MockProfileRepo mockProfileRepo;

  setUp(() {
    mockProfileRepo = MockProfileRepo();
    usecase = GetOrdersUsecases(mockProfileRepo);
  });

  const tToken = 'test_token';
  final tOrderResponse = OrderResponse(message: 'Success', orders: []);

  test('should call getOrders from repository', () async {
    // arrange
    provideDummy<ApiResult<OrderResponse>>(
      SuccessApiResult(data: tOrderResponse),
    );
    when(
      mockProfileRepo.getOrders(token: anyNamed('token')),
    ).thenAnswer((_) async => SuccessApiResult(data: tOrderResponse));

    // act
    final result = await usecase(token: tToken);

    // assert
    expect(result, isA<SuccessApiResult<OrderResponse>>());
    verify(mockProfileRepo.getOrders(token: tToken)).called(1);
  });

  test('should return ErrorApiResult when repository fails', () async {
    // arrange
    provideDummy<ApiResult<OrderResponse>>(ErrorApiResult(error: 'Some error'));
    when(
      mockProfileRepo.getOrders(token: anyNamed('token')),
    ).thenAnswer((_) async => ErrorApiResult(error: 'Some error'));

    // act
    final result = await usecase(token: tToken);

    // assert
    expect(result, isA<ErrorApiResult<OrderResponse>>());
    verify(mockProfileRepo.getOrders(token: tToken)).called(1);
  });
}
