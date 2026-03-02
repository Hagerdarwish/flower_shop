import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/addresses/data/models/get_address_response.dart';
import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';

void main() {
  group('GetAddressResponse', () {
    final addressJson = {
      "_id": "1",
      "street": "Main Street",
      "phone": "01000000000",
      "city": "Cairo",
      "lat": "30.01",
      "long": "31.02",
      "username": "Ali",
    };

    final responseJson = {
      "error": null,
      "message": "Success",
      "addresses": [addressJson],
    };

    test('fromJson should parse JSON correctly', () {
      final response = GetAddressResponse.fromJson(responseJson);

      expect(response.error, isNull);
      expect(response.message, 'Success');
      expect(response.addresses, isNotNull);
      expect(response.addresses!.length, 1);
      expect(response.addresses!.first.street, 'Main Street');
    });

    test('toEntityList should convert addresses to AddressEntity', () {
      final address = Address(
        id: '1',
        street: 'Main Street',
        phone: '01000000000',
        city: 'Cairo',
        lat: '30.01',
        long: '31.02',
        username: 'Ali',
      );

      final response = GetAddressResponse(
        error: null,
        message: 'Success',
        addresses: [address],
      );

      final entities = response.toEntityList();

      expect(entities, isA<List<AddressEntity>>());
      expect(entities.first.street, 'Main Street');
      expect(entities.first.username, 'Ali');
    });
  });
}
