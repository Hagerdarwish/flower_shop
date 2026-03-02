import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flower_shop/features/addresses/presentation/add_address/manager/add_address_cubit.dart';
import 'package:flower_shop/features/addresses/presentation/add_address/manager/add_address_events.dart';
import 'package:flower_shop/features/addresses/presentation/add_address/manager/add_address_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/models/response/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_dto.dart';
import 'package:flower_shop/features/addresses/domain/usecase/add_address_usecase.dart';
import 'address_cubit_test.mocks.dart';

@GenerateMocks([AddAddressUsecase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAddAddressUsecase mockUsecase;

  final statesJson = jsonEncode([
    {"type": "header", "version": "5.0.2"},
    {"type": "database", "name": "test"},
    {
      "type": "table",
      "name": "cities",
      "database": "test",
      "data": [
        {
          "id": "10",
          "governorate_id": "1",
          "city_name_ar": "مدينة نصر",
          "city_name_en": "Nasr City",
        },
        {
          "id": "11",
          "governorate_id": "1",
          "city_name_ar": "المعادى",
          "city_name_en": "Maadi",
        },
        {
          "id": "12",
          "governorate_id": "2",
          "city_name_ar": "الدقى",
          "city_name_en": "Dokki",
        },
      ],
    },
  ]);

  final governoratesJson = jsonEncode([
    {"type": "header", "version": "5.0.2"},
    {"type": "database", "name": "test"},
    {
      "type": "table",
      "name": "governorates",
      "database": "test",
      "data": [
        {
          "id": "1",
          "governorate_name_ar": "القاهرة",
          "governorate_name_en": "Cairo",
        },
        {
          "id": "2",
          "governorate_name_ar": "الجيزة",
          "governorate_name_en": "Giza",
        },
      ],
    },
  ]);

  setUpAll(() async {
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (ByteData? message) async {
        final key = utf8.decode(message!.buffer.asUint8List());
        String content;

        if (key == 'assets/data/states.json') {
          content = statesJson;
        } else if (key == 'assets/data/cities.json') {
          content = governoratesJson;
        } else {
          content = '[]';
        }

        final bytes = Uint8List.fromList(utf8.encode(content));
        return ByteData.view(bytes.buffer);
      },
    );
  });

  setUp(() {
    mockUsecase = MockAddAddressUsecase();
  });

  AddAddressCubit buildCubit() => AddAddressCubit(mockUsecase);

  group('AddAddressCubit - loadLookups', () {
    blocTest<AddAddressCubit, AddAddressState>(
      'LoadLookupsEvent should load areas + cities and set allAreas=areas',
      build: buildCubit,
      act: (cubit) => cubit.doIntent(LoadLookupsEvent()),
      wait: const Duration(milliseconds: 20),
      verify: (cubit) {
        expect(cubit.state.cities.length, 2); // Cairo, Giza
        expect(cubit.state.area.length, 3); // Nasr City, Maadi, Dokki
        expect(cubit.state.allAreas.length, 3);
      },
    );
  });

  group('AddAddressCubit - city selection filters areas', () {
    blocTest<AddAddressCubit, AddAddressState>(
      'CitySelectedEvent filters area by governorateId and resets selectedArea',
      build: buildCubit,
      act: (cubit) async {
        cubit.doIntent(LoadLookupsEvent());
        await Future<void>.delayed(const Duration(milliseconds: 20));

        final cairo = cubit.state.cities.firstWhere((c) => c.id == '1');
        cubit.doIntent(CitySelectedEvent(cairo));
      },
      wait: const Duration(milliseconds: 20),
      verify: (cubit) {
        expect(cubit.state.selectedCity?.id, '1');
        expect(cubit.state.selectedArea, isNull);

        expect(cubit.state.area.length, 2); // Nasr City + Maadi
        expect(cubit.state.area.every((a) => a.governorateId == '1'), isTrue);
      },
    );
  });

  group('AddAddressCubit - submit', () {
    const token = 'Bearer test_token';

    blocTest<AddAddressCubit, AddAddressState>(
      'SubmitAddAddressEvent emits loading then success when usecase succeeds',
      build: buildCubit,
      setUp: () {
        when(
          mockUsecase(token: anyNamed('token'), data: anyNamed('data')),
        ).thenAnswer(
          (_) async =>
              SuccessApiResult<AddressDto>(data: AddressDto(message: 'ok')),
        );
      },
      act: (cubit) async {
        cubit.doIntent(LoadLookupsEvent());
        await Future<void>.delayed(const Duration(milliseconds: 20));

        cubit.doIntent(AddressChangedEvent('Street 1'));
        cubit.doIntent(PhoneChangedEvent('01000000000')); // ✅ removed ?.
        cubit.doIntent(RecipientChangedEvent('Maiar')); // ✅ removed ?.

        final cairo = cubit.state.cities.firstWhere((c) => c.id == '1');
        cubit.doIntent(CitySelectedEvent(cairo));
        await Future<void>.delayed(const Duration(milliseconds: 10));

        cubit.doIntent(AreaSelectedEvent(cubit.state.area.first));
        cubit.doIntent(LocationPickedEvent(lat: 30.1, lng: 31.2));
        cubit!.doIntent(SubmitAddAddressEvent(token));
      },
      wait: const Duration(milliseconds: 30),
      verify: (cubit) {
        expect(cubit.state.submitResult.status, Status.success);

        final captured =
            verify(
                  mockUsecase(
                    token: anyNamed('token'),
                    data: captureAnyNamed('data'),
                  ),
                ).captured.single
                as AddressModel;

        expect(captured.street, 'Street 1');
        expect(captured.phone, '01000000000');
        expect(captured.username, 'Maiar');
        expect(captured.city, 'Cairo');
        expect(captured.lat, '30.1');
        expect(captured.long, '31.2');
      },
    );
  });
}
