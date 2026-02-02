import 'package:flutter/foundation.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';
import 'package:flower_shop/features/addresses/domain/repos/address_repo.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_cubit.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_states.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_intent.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/network/api_result.dart';

@GenerateMocks([AddressRepo, AuthStorage])
import 'saved_address_cubit_test.mocks.dart';

void main() {
  provideDummy<SuccessApiResult<List<AddressEntity>>>(
    SuccessApiResult<List<AddressEntity>>(data: []),
  );

  provideDummy<ErrorApiResult<List<AddressEntity>>>(
    ErrorApiResult<List<AddressEntity>>(error: 'dummy error'),
  );

  provideDummy<ApiResult<List<AddressEntity>>>(
    SuccessApiResult<List<AddressEntity>>(data: []),
  );

  late MockAddressRepo mockAddressRepo;
  late MockAuthStorage mockAuthStorage;
  late SavedAddressCubit cubit;

  setUp(() {
    mockAddressRepo = MockAddressRepo();
    mockAuthStorage = MockAuthStorage();
    cubit = SavedAddressCubit(mockAddressRepo, mockAuthStorage);
  });

  group('SavedAddressCubit Tests', () {
    const fakeToken = 'fake_token';
    final fakeAddress = AddressEntity(
      id: '1',
      street: 'Main Street',
      phone: '01000000000',
      city: 'Cairo',
      lat: '30.01',
      long: '31.02',
      username: 'Ali',
    );

    test('getAddresses emits success when repo returns data', () async {
      // arrange
      when(mockAuthStorage.getToken()).thenAnswer((_) async => fakeToken);
      when(
        mockAddressRepo.getAddresses(token: 'Bearer $fakeToken'),
      ).thenAnswer((_) async => SuccessApiResult(data: [fakeAddress]));

      // act
      // act & assert
      expectLater(
        cubit.stream,
        emitsInOrder([
          predicate<SavedAddressStates>(
            (state) => state.addressesResource.status == Status.loading,
          ),
          predicate<SavedAddressStates>(
            (state) =>
                state.addressesResource.status == Status.success &&
                listEquals(state.addressesResource.data, [fakeAddress]),
          ),
        ]),
      );
      cubit.doIntent(GetAddressesIntent());
    });

    test('getAddresses emits error when token is null', () async {
      when(mockAuthStorage.getToken()).thenAnswer((_) async => null);

      expectLater(
        cubit.stream,
        emitsInOrder([
          predicate<SavedAddressStates>(
            (state) => state.addressesResource.status == Status.loading,
          ),
          predicate<SavedAddressStates>(
            (state) =>
                state.addressesResource.status == Status.error &&
                state.addressesResource.error == 'Token not found',
          ),
        ]),
      );
      cubit.doIntent(GetAddressesIntent());
    });

    test('deleteAddress emits success when repo returns data', () async {
      when(mockAuthStorage.getToken()).thenAnswer((_) async => fakeToken);
      when(
        mockAddressRepo.deleteAddress(
          token: 'Bearer $fakeToken',
          addressId: '1',
        ),
      ).thenAnswer((_) async => SuccessApiResult(data: [fakeAddress]));

      expectLater(
        cubit.stream,
        emitsInOrder([
          predicate<SavedAddressStates>(
            (state) => state.addressesResource.status == Status.loading,
          ),
          predicate<SavedAddressStates>(
            (state) =>
                state.addressesResource.status == Status.success &&
                listEquals(state.addressesResource.data, [fakeAddress]),
          ),
        ]),
      );
      cubit.doIntent(DeleteAddressIntent(addressId: '1'));
    });

    test('editAddress emits success when repo returns data', () async {
      when(mockAuthStorage.getToken()).thenAnswer((_) async => fakeToken);
      when(
        mockAddressRepo.editAddress(
          token: 'Bearer $fakeToken',
          addressId: '1',
          street: 'Main Street',
          phone: '01000000000',
          city: 'Cairo',
          lat: '30.01',
          long: '31.02',
          username: 'Ali',
        ),
      ).thenAnswer((_) async => SuccessApiResult(data: [fakeAddress]));

      expectLater(
        cubit.stream,
        emitsInOrder([
          predicate<SavedAddressStates>(
            (state) => state.addressesResource.status == Status.loading,
          ),
          predicate<SavedAddressStates>(
            (state) =>
                state.addressesResource.status == Status.success &&
                listEquals(state.addressesResource.data, [fakeAddress]),
          ),
        ]),
      );
      cubit.doIntent(
        EditAddressIntent(
          addressId: '1',
          street: 'Main Street',
          phone: '01000000000',
          city: 'Cairo',
          lat: '30.01',
          long: '31.02',
          username: 'Ali',
        ),
      );
    });
  });
}
