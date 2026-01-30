import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource.dart';
import 'package:flower_shop/features/addresses/data/models/response/add_address_response_model.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import 'package:flower_shop/features/addresses/data/repos/address_repo_imp.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_repo_impl_test.mocks.dart';

@GenerateMocks([AddressDatasource])
void main() {
  late AddressRepoImpl repo;
  late MockAddressDatasource mockAddressDatasource;

  setUp(() {
    mockAddressDatasource = MockAddressDatasource();
    repo = AddressRepoImpl(mockAddressDatasource);
  });

  const tToken = 'sample_token';
  final tAddressModel = AddressModel(
    username: 'Home',
    city: 'Cairo',
    street: '123 Main St',
    phone: '1234567890',
  );
  final tAddAddressResponseModel = AddAddressResponse(
    message: 'success',
    address:[
      AddressModel(
        username: 'Home',
        city: 'Cairo',
        street: '123 Main St',
        phone: '1234567890',
      ),
    ]
  );

  group('AddressRepoImpl', () {
    test(
        'should return AddressDto when the call to datasource is successful', () async {
      // Arrange
      when(mockAddressDatasource.addAddress(any, any))
          .thenAnswer((_) async => SuccessApiResult(data: tAddAddressResponseModel));

      // Act
      final result = await repo.addAddress(tToken, tAddressModel);

      // Assert
      expect(result, isA<SuccessApiResult<AddressDto>>());
      expect((result as SuccessApiResult<AddressDto>).data.message,"success");
      verify(mockAddressDatasource.addAddress(tToken, tAddressModel));
      verifyNoMoreInteractions(mockAddressDatasource);
    });

    test(
        'should return ErrorApiResult when the call to datasource is unsuccessful', () async {
      // Arrange
      const errorMessage = 'Failed to add address';
      when(mockAddressDatasource.addAddress(any, any))
          .thenAnswer((_) async =>  ErrorApiResult(error: errorMessage));

      // Act
      final result = await repo.addAddress(tToken, tAddressModel);

      // Assert
      expect(result, isA<ErrorApiResult<AddressDto>>());
      expect((result as ErrorApiResult<AddressDto>).error, errorMessage);
      verify(mockAddressDatasource.addAddress(tToken, tAddressModel));
      verifyNoMoreInteractions(mockAddressDatasource);
    });
  });
}
