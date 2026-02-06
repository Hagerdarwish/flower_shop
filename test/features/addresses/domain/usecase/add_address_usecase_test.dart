import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:flower_shop/features/addresses/domain/usecase/add_address_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_address_usecase_test.mocks.dart';

@GenerateMocks([AddressRepo])
void main() {
  late AddAddressUsecase usecase;
  late MockAddressRepo mockAddressRepo;

  setUp(() {
    mockAddressRepo = MockAddressRepo();
    usecase = AddAddressUsecase(mockAddressRepo);
  });

  const tToken = 'sample_token';
  final tAddressModel = AddressModel(
    username: 'Home',
    city: 'Cairo',
    street: '123 Main St',
    phone: '1234567890',
  );
  final tAddressDto = AddressDto(message: "");

  group('AddAddressUsecase', () {
    test(
      'should return success result when repository call is successful',
      () async {
        // Arrange
        final successResult = SuccessApiResult(data: tAddressDto);
        provideDummy<ApiResult<AddressDto>>(successResult);
        when(
          mockAddressRepo.addAddress(any, any),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await usecase.call(token: tToken, data: tAddressModel);

        // Assert
        expect(result, equals(successResult));
        verify(mockAddressRepo.addAddress(tToken, tAddressModel));
        verifyNoMoreInteractions(mockAddressRepo);
      },
    );

    test('should return error result when repository call fails', () async {
      // Arrange
      const errorMessage = 'Failed to add address';
      final errorResult = ErrorApiResult<AddressDto>(error: errorMessage);
      provideDummy<ApiResult<AddressDto>>(errorResult);

      when(
        mockAddressRepo.addAddress(any, any),
      ).thenAnswer((_) async => errorResult);

      // Act
      final result = await usecase.call(token: tToken, data: tAddressModel);

      // Assert
      expect(result, equals(errorResult));
      verify(mockAddressRepo.addAddress(tToken, tAddressModel));
      verifyNoMoreInteractions(mockAddressRepo);
    });
  });
}
