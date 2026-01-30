import 'package:flower_shop/features/addresses/data/repos/address_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/data/models/get_address_response.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/data/models/address_model.dart';

import 'address_repo_imp_test.mocks.dart';

@GenerateMocks([AddressDatasource])
void main() {
  late MockAddressDatasource mockDatasource;
  late AddressRepoImp repo;

  setUp(() {
    mockDatasource = MockAddressDatasource();
    repo = AddressRepoImp(addressDatasource: mockDatasource);
  });

  group('AddressRepoImp - getAddresses', () {
    test('returns SuccessApiResult when datasource succeeds', () async {
      const token = 'token';
      final getAddressResponse = GetAddressResponse(
        addresses: [
          Address(
            id: '1',
            street: 'Street 1',
            phone: '01000000000',
            city: 'Cairo',
            lat: '30.01',
            long: '31.02',
            username: 'Ali',
          ),
        ],
      );

      when(mockDatasource.getAddresses(token: token)).thenAnswer(
        (_) async =>
            SuccessApiResult<GetAddressResponse>(data: getAddressResponse),
      );

      final result = await repo.getAddresses(token: token);

      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());
      expect(
        (result as SuccessApiResult<List<AddressEntity>>).data.first.id,
        '1',
      );
    });

    test('returns ErrorApiResult when datasource fails', () async {
      const token = 'token';
      when(mockDatasource.getAddresses(token: token)).thenAnswer(
        (_) async => ErrorApiResult<GetAddressResponse>(error: 'Fetch failed'),
      );

      final result = await repo.getAddresses(token: token);

      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect(
        (result as ErrorApiResult<List<AddressEntity>>).error,
        'Fetch failed',
      );
    });
  });

  group('AddressRepoImp - deleteAddress', () {
    test('returns SuccessApiResult when datasource succeeds', () async {
      const token = 'token';
      const addressId = '1';

      final addressResponse = AddressResponse(
        address: [
          Address(
            id: '1',
            street: 'Street 1',
            phone: '01000000000',
            city: 'Cairo',
            lat: '30.01',
            long: '31.02',
            username: 'Ali',
          ),
        ],
      );

      when(
        mockDatasource.deleteAddress(token: token, addressId: addressId),
      ).thenAnswer(
        (_) async => SuccessApiResult<AddressResponse>(data: addressResponse),
      );

      final result = await repo.deleteAddress(
        token: token,
        addressId: addressId,
      );

      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());
      expect(
        (result as SuccessApiResult<List<AddressEntity>>).data.first.id,
        '1',
      );
    });

    test('returns ErrorApiResult when datasource fails', () async {
      const token = 'token';
      const addressId = '1';

      when(
        mockDatasource.deleteAddress(token: token, addressId: addressId),
      ).thenAnswer(
        (_) async => ErrorApiResult<AddressResponse>(error: 'Delete failed'),
      );

      final result = await repo.deleteAddress(
        token: token,
        addressId: addressId,
      );

      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect(
        (result as ErrorApiResult<List<AddressEntity>>).error,
        'Delete failed',
      );
    });
  });

  group('AddressRepoImp - editAddress', () {
    test('returns SuccessApiResult when datasource succeeds', () async {
      const token = 'token';
      const addressId = '1';

      final addressResponse = AddressResponse(
        address: [
          Address(
            id: '1',
            street: 'Updated Street',
            phone: '01111111111',
            city: 'Giza',
            lat: '30.02',
            long: '31.03',
            username: 'Ali',
          ),
        ],
      );

      when(
        mockDatasource.editAddress(
          token: token,
          addressId: addressId,
          addressRequest: anyNamed('addressRequest'),
        ),
      ).thenAnswer(
        (_) async => SuccessApiResult<AddressResponse>(data: addressResponse),
      );

      final result = await repo.editAddress(
        token: token,
        addressId: addressId,
        street: 'Updated Street',
        phone: '01111111111',
        city: 'Giza',
        lat: '30.02',
        long: '31.03',
        username: 'Ali',
      );

      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());
      expect(
        (result as SuccessApiResult<List<AddressEntity>>).data.first.street,
        'Updated Street',
      );
    });

    test('returns ErrorApiResult when datasource fails', () async {
      const token = 'token';
      const addressId = '1';

      when(
        mockDatasource.editAddress(
          token: token,
          addressId: addressId,
          addressRequest: anyNamed('addressRequest'),
        ),
      ).thenAnswer(
        (_) async => ErrorApiResult<AddressResponse>(error: 'Edit failed'),
      );

      final result = await repo.editAddress(
        token: token,
        addressId: addressId,
        street: 'Updated Street',
        phone: '01111111111',
        city: 'Giza',
        lat: '30.02',
        long: '31.03',
        username: 'Ali',
      );

      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect(
        (result as ErrorApiResult<List<AddressEntity>>).error,
        'Edit failed',
      );
    });
  });
}
