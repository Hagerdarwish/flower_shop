import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/addresses/domain/models/address_entity.dart';

void main() {
  group('AddressEntity', () {
    test('should create an instance with correct values', () {
      // arrange
      const id = '1';
      const street = 'Main Street';
      const phone = '01000000000';
      const city = 'Cairo';
      const lat = '30.01';
      const long = '31.02';
      const username = 'Ali';

      // act
      const address = AddressEntity(
        id: id,
        street: street,
        phone: phone,
        city: city,
        lat: lat,
        long: long,
        username: username,
      );

      // assert
      expect(address.id, id);
      expect(address.street, street);
      expect(address.phone, phone);
      expect(address.city, city);
      expect(address.lat, lat);
      expect(address.long, long);
      expect(address.username, username);
    });

    test('should be equal when values are the same', () {
      // arrange
      const address1 = AddressEntity(
        id: '1',
        street: 'Main Street',
        phone: '01000000000',
        city: 'Cairo',
        lat: '30.01',
        long: '31.02',
        username: 'Ali',
      );

      const address2 = AddressEntity(
        id: '1',
        street: 'Main Street',
        phone: '01000000000',
        city: 'Cairo',
        lat: '30.01',
        long: '31.02',
        username: 'Ali',
      );

      // assert
      expect(address1, equals(address2));
    });
  });
}
