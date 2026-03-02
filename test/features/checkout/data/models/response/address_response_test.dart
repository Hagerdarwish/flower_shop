import 'package:flower_shop/features/checkout/data/models/response/address_check_out_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';

void main() {
  group('AddressResponse', () {
    test('fromJson parses AddressResponse correctly', () {
      // arrange
      final json = {
        "message": "address fetched successfully",
        "addresses": [
          {
            "_id": "addr_1",
            "username": "Rahma",
            "phone": "01000000000",
            "city": "Cairo",
            "street": "Nasr City",
            "lat": 30.0444,
            "long": 31.2357,
          },
        ],
      };

      // act
      final response = AddressCheckOutResponse.fromJson(json);

      // assert
      expect(response.message, "address fetched successfully");
      expect(response.addresses.length, 1);

      final address = response.addresses.first;
      expect(address.id, "addr_1");
      expect(address.username, "Rahma");
      expect(address.city, "Cairo");
      expect(address.lat, 30.0444);
      expect(address.long, 31.2357);
    });

    test('toJson returns correct json structure', () {
      // arrange
      final response = AddressCheckOutResponse(
        message: "success",
        addresses: [
          Address(
            id: "addr_1",
            username: "Rahma",
            phone: "01000000000",
            city: "Giza",
            street: "Dokki",
            lat: "30.1",
            long: "31.2",
          ),
        ],
      );

      // act
      final json = response.toJson();

      // assert
      expect(json['message'], "success");
      expect(json['addresses'], isA<List>());

      final firstAddress = response.addresses.first;
      expect(firstAddress.id, "addr_1");
      expect(firstAddress.city, "Giza");
      expect(firstAddress.lat, "30.1");
      expect(firstAddress.long, "31.2");
    });

    test('toDomain maps AddressResponse to List<AddressModel>', () {
      // arrange
      final response = AddressCheckOutResponse(
        message: "success",
        addresses: [
          Address(
            id: "addr_1",
            username: "Rahma",
            phone: "01000000000",
            city: "Alex",
            street: "Stanley",
            lat: "30.000",
            long: 31, // int on purpose
          ),
        ],
      );

      // act
      final domain = response.toDomain();

      // assert
      expect(domain, isA<List<AddressModel>>());
      expect(domain.length, 1);

      final model = domain.first;
      expect(model.id, "addr_1");
      expect(model.city, "Alex");
      expect(model.lat, 30.0);
      expect(model.long, 31.0);
    });

    test('safeDouble handles null and invalid values', () {
      // arrange
      final response = AddressCheckOutResponse(
        message: "success",
        addresses: [
          Address(
            id: "addr_1",
            username: "Rahma",
            phone: "01000000000",
            city: "Cairo",
            street: "Heliopolis",
            lat: null,
            long: "invalid",
          ),
        ],
      );

      // act
      final model = response.toDomain().first;

      // assert
      expect(model.lat, 0.0);
      expect(model.long, 0.0);
    });
  });
}
