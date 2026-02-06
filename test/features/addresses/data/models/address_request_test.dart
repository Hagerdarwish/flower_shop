import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';

void main() {
  group('AddressRequest', () {
    final requestJson = {
      "street": "Main Street",
      "phone": "01000000000",
      "city": "Cairo",
      "lat": "30.01",
      "long": "31.02",
      "username": "Ali",
    };

    test('fromJson should parse JSON correctly', () {
      final request = AddressRequest.fromJson(requestJson);

      expect(request.street, 'Main Street');
      expect(request.phone, '01000000000');
      expect(request.city, 'Cairo');
      expect(request.lat, '30.01');
      expect(request.long, '31.02');
      expect(request.username, 'Ali');
    });

    test('toJson should convert AddressRequest to JSON correctly', () {
      final request = AddressRequest(
        street: 'Main Street',
        phone: '01000000000',
        city: 'Cairo',
        lat: '30.01',
        long: '31.02',
        username: 'Ali',
      );

      final json = request.toJson();

      expect(json['street'], 'Main Street');
      expect(json['phone'], '01000000000');
      expect(json['city'], 'Cairo');
      expect(json['lat'], '30.01');
      expect(json['long'], '31.02');
      expect(json['username'], 'Ali');
    });
  });
}
