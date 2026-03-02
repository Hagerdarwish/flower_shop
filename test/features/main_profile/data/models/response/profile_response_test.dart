import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

void main() {
  test('ProfileResponse toDomain should return ProfileUserModel', () {
    final response = ProfileResponse(
      message: "success",
      profileUserModel: ProfileUserModel(
        id: "1",
        firstName: "Rahma",
        email: "rahma@test.com",
      ),
    );

    final domainUser = response.toDomain();

    expect(domainUser.id, "1");
    expect(domainUser.firstName, "Rahma");
    expect(domainUser.email, "rahma@test.com");
  });
}
