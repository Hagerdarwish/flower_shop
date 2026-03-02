import 'package:flower_shop/features/checkout/domain/usecases/get_addresss_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/repos/checkout_repo.dart';

import 'post_cashe_order_usecase_test.mocks.dart';

// Define dummy value at the top level
ApiResult<List<AddressModel>> dummyApiResult =
    SuccessApiResult<List<AddressModel>>(data: []);

@GenerateMocks([CheckoutRepo])
void main() {
  late MockCheckoutRepo mockRepo;
  late GetAddressUsecase usecase;

  const token = 'Bearer test-token';

  // Provide dummy value BEFORE any tests run
  setUpAll(() {
    provideDummy<ApiResult<List<AddressModel>>>(dummyApiResult);
  });

  setUp(() {
    mockRepo = MockCheckoutRepo();
    usecase = GetAddressUsecase(mockRepo);
  });

  group('GetAddressUsecase', () {
    test(
      'returns SuccessApiResult<List<AddressModel>> when repo succeeds',
      () async {
        // arrange
        final fakeAddresses = [
          AddressModel(
            id: 'addr_1',
            username: 'Rahma',
            phone: '01000000000',
            city: 'Cairo',
            street: 'Nasr City',
            lat: 30.0,
            long: 31.0,
          ),
        ];

        when(
          mockRepo.getAddress(token),
        ).thenAnswer((_) async => SuccessApiResult(data: fakeAddresses));

        // act
        final result = await usecase(token);

        // assert
        expect(result, isA<SuccessApiResult<List<AddressModel>>>());
        expect((result as SuccessApiResult<List<AddressModel>>).data.length, 1);

        verify(mockRepo.getAddress(token)).called(1);
        verifyNoMoreInteractions(mockRepo);
      },
    );

    test('returns ErrorApiResult when repo fails', () async {
      // arrange
      when(mockRepo.getAddress(token)).thenAnswer(
        (_) async => ErrorApiResult<List<AddressModel>>(error: 'network error'),
      );

      // act
      final result = await usecase(token);

      // assert
      expect(result, isA<ErrorApiResult<List<AddressModel>>>());
      expect(
        (result as ErrorApiResult<List<AddressModel>>).error,
        'network error',
      );

      verify(mockRepo.getAddress(token)).called(1);
    });
  });
}
