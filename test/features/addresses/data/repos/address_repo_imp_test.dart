import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/data/models/get_address_response.dart';
import 'package:flower_shop/features/addresses/data/models/response/add_address_response_model.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import 'package:flower_shop/features/addresses/data/repos/address_repo_imp.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';

import 'address_repo_imp_test.mocks.dart';

@GenerateMocks([AddressDatasource])
void main() {
  late MockAddressDatasource mockDatasource;
  late AddressRepoImp repo;

  const tToken = 'sample_token';

  setUp(() {
    mockDatasource = MockAddressDatasource();
    repo = AddressRepoImp(addressDatasource: mockDatasource);
  });

  // --------------------------------------------------
  // addAddress
  // --------------------------------------------------
  group('addAddress', () {
    final tRequest = AddressModel(
      username: 'Home',
      city: 'Cairo',
      street: '123 Main St',
      phone: '1234567890',
    );

    final tResponse = AddAddressResponse(
      message: 'success',
      address: [
        AddressModel(
          username: 'Home',
          city: 'Cairo',
          street: '123 Main St',
          phone: '1234567890',
          lat: '30.0',
          long: '31.0',
        ),
      ],
    );

    test('returns SuccessApiResult<AddressDto> on success', () async {
      when(
        mockDatasource.addAddress(any, any),
      ).thenAnswer((_) async => SuccessApiResult(data: tResponse));

      final result = await repo.addAddress(tToken, tRequest);

      expect(result, isA<SuccessApiResult<AddressDto>>());
      expect((result as SuccessApiResult).data.message, 'success');

      verify(mockDatasource.addAddress(tToken, tRequest));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('returns ErrorApiResult on failure', () async {
      when(
        mockDatasource.addAddress(any, any),
      ).thenAnswer((_) async => ErrorApiResult(error: 'Failed'));

      final result = await repo.addAddress(tToken, tRequest);

      expect(result, isA<ErrorApiResult<AddressDto>>());
      expect((result as ErrorApiResult).error, 'Failed');

      verify(mockDatasource.addAddress(tToken, tRequest));
    });
  });

  // --------------------------------------------------
  // getAddresses
  // --------------------------------------------------
  group('getAddresses', () {
    final tAddress = Address(
      id: '1',
      street: 'Test St',
      phone: '123',
      city: 'Cairo',
      lat: '1',
      long: '1',
      username: 'Maiar',
    );

    test('returns list of AddressEntity on success', () async {
      when(mockDatasource.getAddresses(token: anyNamed('token'))).thenAnswer(
        (_) async =>
            SuccessApiResult(data: GetAddressResponse(addresses: [tAddress])),
      );

      final result = await repo.getAddresses(token: tToken);

      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());
      expect((result as SuccessApiResult).data.first.id, '1');

      verify(mockDatasource.getAddresses(token: tToken));
    });

    test('returns ErrorApiResult on failure', () async {
      when(
        mockDatasource.getAddresses(token: anyNamed('token')),
      ).thenAnswer((_) async => ErrorApiResult(error: 'Failed'));

      final result = await repo.getAddresses(token: tToken);

      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect((result as ErrorApiResult).error, 'Failed');

      verify(mockDatasource.getAddresses(token: tToken));
    });
  });

  // --------------------------------------------------
  // deleteAddress
  // --------------------------------------------------
  group('deleteAddress', () {
    test('returns list of AddressEntity on success', () async {
      when(
        mockDatasource.deleteAddress(
          token: anyNamed('token'),
          addressId: anyNamed('addressId'),
        ),
      ).thenAnswer(
        (_) async => SuccessApiResult(
          data: AddressResponse(
            address: [
              Address(
                id: '1',
                street: 'X',
                phone: '1',
                city: 'C',
                lat: '1',
                long: '1',
                username: 'U',
              ),
            ],
          ),
        ),
      );

      final result = await repo.deleteAddress(token: tToken, addressId: '1');

      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());

      verify(mockDatasource.deleteAddress(token: tToken, addressId: '1'));
    });

    test('returns ErrorApiResult on failure', () async {
      when(
        mockDatasource.deleteAddress(
          token: anyNamed('token'),
          addressId: anyNamed('addressId'),
        ),
      ).thenAnswer((_) async => ErrorApiResult(error: 'Failed'));

      final result = await repo.deleteAddress(token: tToken, addressId: '1');

      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect((result as ErrorApiResult).error, 'Failed');
    });
  });

  // --------------------------------------------------
  // editAddress
  // --------------------------------------------------
  group('editAddress', () {
    test('returns list of AddressEntity on success', () async {
      when(
        mockDatasource.editAddress(
          token: anyNamed('token'),
          addressId: anyNamed('addressId'),
          addressRequest: anyNamed('addressRequest'),
        ),
      ).thenAnswer(
        (_) async => SuccessApiResult(
          data: AddressResponse(
            address: [
              Address(
                id: '1',
                street: 'New',
                phone: '9',
                city: 'C',
                lat: '2',
                long: '2',
                username: 'U',
              ),
            ],
          ),
        ),
      );

      final result = await repo.editAddress(
        token: tToken,
        addressId: '1',
        street: 'New',
        phone: '9',
        city: 'C',
        lat: '2',
        long: '2',
        username: 'U',
      );

      expect(result, isA<SuccessApiResult<List<AddressEntity>>>());

      verify(
        mockDatasource.editAddress(
          token: tToken,
          addressId: '1',
          addressRequest: anyNamed('addressRequest'),
        ),
      );
    });

    test('returns ErrorApiResult on failure', () async {
      when(
        mockDatasource.editAddress(
          token: anyNamed('token'),
          addressId: anyNamed('addressId'),
          addressRequest: anyNamed('addressRequest'),
        ),
      ).thenAnswer((_) async => ErrorApiResult(error: 'Failed'));

      final result = await repo.editAddress(
        token: tToken,
        addressId: '1',
        street: 'New',
        phone: '9',
        city: 'C',
        lat: '2',
        long: '2',
        username: 'U',
      );

      expect(result, isA<ErrorApiResult<List<AddressEntity>>>());
      expect((result as ErrorApiResult).error, 'Failed');
    });
  });
}
