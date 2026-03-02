import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:flower_shop/features/addresses/domain/usecases/edit_user_address.dart';

import 'edit_user_address_test.mocks.dart';

@GenerateMocks([AddressRepo])
void main() {
  provideDummy<ApiResult<List<AddressEntity>>>(
    SuccessApiResult<List<AddressEntity>>(data: const []),
  );

  group('EditUserAddress UseCase', () {
    late EditUserAddress editUserAddress;
    late MockAddressRepo mockAddressRepo;

    setUp(() {
      mockAddressRepo = MockAddressRepo();
      editUserAddress = EditUserAddress(mockAddressRepo);
    });

    test('returns SuccessApiResult when editAddress succeeds', () async {
      // arrange
      const token = 'fake_token';
      const addressId = 'address_123';

      final updatedAddresses = [
        AddressEntity(
          id: '1',
          street: 'New Street',
          phone: '01111111111',
          city: 'Giza',
          lat: '30.01',
          long: '31.02',
          username: 'Ali',
        ),
      ];

      final successResult = SuccessApiResult<List<AddressEntity>>(
        data: updatedAddresses,
      );

      when(
        mockAddressRepo.editAddress(
          token: token,
          addressId: addressId,
          street: anyNamed('street'),
          phone: anyNamed('phone'),
          city: anyNamed('city'),
          lat: anyNamed('lat'),
          long: anyNamed('long'),
          username: anyNamed('username'),
        ),
      ).thenAnswer((_) async => successResult);

      // act
      final result = await editUserAddress(
        token: token,
        addressId: addressId,
        street: 'New Street',
        phone: '01111111111',
        city: 'Giza',
        lat: '30.01',
        long: '31.02',
        username: 'Ali',
      );

      // assert
      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());
      expect(
        (result as SuccessApiResult<List<AddressEntity>>).data,
        updatedAddresses,
      );

      verify(
        mockAddressRepo.editAddress(
          token: token,
          addressId: addressId,
          street: 'New Street',
          phone: '01111111111',
          city: 'Giza',
          lat: '30.01',
          long: '31.02',
          username: 'Ali',
        ),
      ).called(1);
    });

    test('returns ErrorApiResult when editAddress fails', () async {
      // arrange
      const token = 'fake_token';
      const addressId = 'address_123';

      final errorResult = ErrorApiResult<List<AddressEntity>>(
        error: 'Edit failed',
      );

      when(
        mockAddressRepo.editAddress(
          token: token,
          addressId: addressId,
          street: anyNamed('street'),
          phone: anyNamed('phone'),
          city: anyNamed('city'),
          lat: anyNamed('lat'),
          long: anyNamed('long'),
          username: anyNamed('username'),
        ),
      ).thenAnswer((_) async => errorResult);

      // act
      final result = await editUserAddress(token: token, addressId: addressId);

      // assert
      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect(
        (result as ErrorApiResult<List<AddressEntity>>).error,
        'Edit failed',
      );
    });
  });
}
