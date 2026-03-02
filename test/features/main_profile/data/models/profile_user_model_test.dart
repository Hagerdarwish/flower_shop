import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

void main() {
  test('ProfileUserModel fromJson should parse correctly', () {
    final json = {
      "_id": "1",
      "firstName": "Rahma",
      "lastName": "Ahmed",
      "email": "rahma@test.com",
      "gender": "female",
    };

    final model = ProfileUserModel.fromJson(json);

    expect(model.id, "1");
    expect(model.firstName, "Rahma");
    expect(model.lastName, "Ahmed");
    expect(model.email, "rahma@test.com");
    expect(model.gender, "female");
  });
}
