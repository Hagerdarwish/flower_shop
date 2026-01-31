import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';

void main() {
  group('AddressResponse', () {
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
      "message": "Success",
      "error": null,
      "address": [addressJson],
    };

    test('fromJson should parse JSON correctly', () {
      final response = AddressResponse.fromJson(responseJson);

      expect(response.message, 'Success');
      expect(response.error, isNull);
      expect(response.address, isNotNull);
      expect(response.address!.length, 1);
      expect(response.address!.first.street, 'Main Street');
      expect(response.address!.first.username, 'Ali');
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

      final response = AddressResponse(
        message: 'Success',
        error: null,
        address: [address],
      );

      final entities = response.toEntityList();

      expect(entities, isA<List<AddressEntity>>());
      expect(entities.first.street, 'Main Street');
      expect(entities.first.username, 'Ali');
      expect(entities.first.id, '1');
    });
  });
}
