import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:flower_shop/features/addresses/domain/usecases/get_user_addresses.dart';

import 'get_user_addresses_test.mocks.dart';

@GenerateMocks([AddressRepo])
void main() {
  provideDummy<ApiResult<List<AddressEntity>>>(
    SuccessApiResult<List<AddressEntity>>(data: const []),
  );

  group('GetUserAddresses UseCase', () {
    late GetUserAddresses getUserAddresses;
    late MockAddressRepo mockAddressRepo;

    setUp(() {
      mockAddressRepo = MockAddressRepo();
      getUserAddresses = GetUserAddresses(addressRepo: mockAddressRepo);
    });

    test('returns SuccessApiResult when getAddresses succeeds', () async {
      // arrange
      const token = 'fake_token';

      final addresses = [
        AddressEntity(
          id: '1',
          street: 'Main Street',
          phone: '01000000000',
          city: 'Cairo',
          lat: '30.01',
          long: '31.02',
          username: 'Ali',
        ),
      ];

      final successResult = SuccessApiResult<List<AddressEntity>>(
        data: addresses,
      );

      when(
        mockAddressRepo.getAddresses(token: token),
      ).thenAnswer((_) async => successResult);

      // act
      final result = await getUserAddresses(token: token);

      // assert
      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());
      expect((result as SuccessApiResult<List<AddressEntity>>).data, addresses);

      verify(mockAddressRepo.getAddresses(token: token)).called(1);
    });

    test('returns ErrorApiResult when getAddresses fails', () async {
      // arrange
      const token = 'fake_token';

      final errorResult = ErrorApiResult<List<AddressEntity>>(
        error: 'Fetch failed',
      );

      when(
        mockAddressRepo.getAddresses(token: token),
      ).thenAnswer((_) async => errorResult);

      // act
      final result = await getUserAddresses(token: token);

      // assert
      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect(
        (result as ErrorApiResult<List<AddressEntity>>).error,
        'Fetch failed',
      );
    });
  });
}
