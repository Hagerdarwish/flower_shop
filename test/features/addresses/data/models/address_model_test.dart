import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';

void main() {
  group('Address', () {
    final addressJson = {
      "_id": "1",
      "street": "Main Street",
      "phone": "01000000000",
      "city": "Cairo",
      "lat": "30.01",
      "long": "31.02",
      "username": "Ali",
    };

    test('fromJson should parse JSON correctly', () {
      final address = Address.fromJson(addressJson);

      expect(address.id, '1');
      expect(address.street, 'Main Street');
      expect(address.phone, '01000000000');
      expect(address.city, 'Cairo');
      expect(address.lat, '30.01');
      expect(address.long, '31.02');
      expect(address.username, 'Ali');
    });

    test('toJson should convert Address to JSON correctly', () {
      final address = Address(
        id: '1',
        street: 'Main Street',
        phone: '01000000000',
        city: 'Cairo',
        lat: '30.01',
        long: '31.02',
        username: 'Ali',
      );

      final json = address.toJson();

      expect(json['_id'], '1');
      expect(json['street'], 'Main Street');
      expect(json['phone'], '01000000000');
      expect(json['city'], 'Cairo');
      expect(json['lat'], '30.01');
      expect(json['long'], '31.02');
      expect(json['username'], 'Ali');
    });

    test('toEntity should convert Address to AddressEntity correctly', () {
      final address = Address(
        id: '1',
        street: 'Main Street',
        phone: '01000000000',
        city: 'Cairo',
        lat: '30.01',
        long: '31.02',
        username: 'Ali',
      );

      final entity = address.toEntity();

      expect(entity, isA<AddressEntity>());
      expect(entity.id, '1');
      expect(entity.street, 'Main Street');
      expect(entity.phone, '01000000000');
      expect(entity.city, 'Cairo');
      expect(entity.lat, '30.01');
      expect(entity.long, '31.02');
      expect(entity.username, 'Ali');
    });
  });
}
