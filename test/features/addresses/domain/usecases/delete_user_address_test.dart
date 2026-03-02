import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:flower_shop/features/addresses/domain/usecases/delete_user_address.dart';

import 'delete_user_address_test.mocks.dart';

@GenerateMocks([AddressRepo])
void main() {
  provideDummy<ApiResult<List<AddressEntity>>>(
    SuccessApiResult<List<AddressEntity>>(data: const []),
  );

  group('DeleteUserAddress UseCase', () {
    late DeleteUserAddress deleteUserAddress;
    late MockAddressRepo mockAddressRepo;

    setUp(() {
      mockAddressRepo = MockAddressRepo();
      deleteUserAddress = DeleteUserAddress(mockAddressRepo);
    });

    test('returns SuccessApiResult when deleteAddress succeeds', () async {
      const token = 'fake_token';
      const addressId = 'address_123';

      final addresses = [
        AddressEntity(
          id: '1',
          street: 'Test Street',
          phone: '01000000000',
          city: 'Cairo',
          lat: '30.0444',
          long: '31.2357',
          username: 'Ali',
        ),
      ];

      final successResult = SuccessApiResult<List<AddressEntity>>(
        data: addresses,
      );

      when(
        mockAddressRepo.deleteAddress(token: token, addressId: addressId),
      ).thenAnswer((_) async => successResult);

      final result = await deleteUserAddress(token, addressId);

      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());
    });

    test('returns ErrorApiResult when deleteAddress fails', () async {
      const token = 'fake_token';
      const addressId = 'address_123';

      final errorResult = ErrorApiResult<List<AddressEntity>>(
        error: 'Delete failed',
      );

      when(
        mockAddressRepo.deleteAddress(token: token, addressId: addressId),
      ).thenAnswer((_) async => errorResult);

      final result = await deleteUserAddress(token, addressId);

      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
    });
  });
}
