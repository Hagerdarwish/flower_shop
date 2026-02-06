import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource_impl.dart';
import 'package:flower_shop/features/addresses/data/models/response/add_address_response_model.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import '../../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late AddressDatasourceImpl datasource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = AddressDatasourceImpl(mockApiClient);
  });

  const tToken = 'sample_token';

  final tAddressModel = AddressModel(
    username: 'Home',
    city: 'Cairo',
    street: '123 Main St',
    phone: '1234567890',
  );

  final tAddAddressResponse = AddAddressResponse(
    message: 'success',
    address: [
      AddressModel(
        username: 'Home',
        city: 'Cairo',
        street: '123 Main St',
        phone: '1234567890',
      ),
    ],
  );

  group('AddressDatasourceImpl', () {
    test(
      'should return SuccessApiResult when api call is successful',
      () async {
        // Arrange
        final httpResponse = HttpResponse(
          tAddAddressResponse,
          Response(
            requestOptions: RequestOptions(path: '/addresses'),
            statusCode: 200,
            data: tAddAddressResponse.toJson(),
          ),
        );

        when(
          mockApiClient.addAddress(
            token: anyNamed('token'),
            request: anyNamed('request'),
          ),
        ).thenAnswer((_) async => httpResponse);

        // Act
        final result = await datasource.addAddress(tToken, tAddressModel);

        // Assert
        expect(result, isA<SuccessApiResult<AddAddressResponse>>());
        expect(
          (result as SuccessApiResult<AddAddressResponse>).data,
          tAddAddressResponse,
        );

        verify(mockApiClient.addAddress(token: tToken, request: tAddressModel));
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test('should return ErrorApiResult when api call throws', () async {
      // Arrange
      when(
        mockApiClient.addAddress(
          token: anyNamed('token'),
          request: anyNamed('request'),
        ),
      ).thenThrow(Exception('Failed to add address'));

      // Act
      final result = await datasource.addAddress(tToken, tAddressModel);

      // Assert
      expect(result, isA<ErrorApiResult<AddAddressResponse>>());

      verify(mockApiClient.addAddress(token: tToken, request: tAddressModel));
      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
