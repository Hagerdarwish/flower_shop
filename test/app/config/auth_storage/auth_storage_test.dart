import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AuthStorage authStorage;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    authStorage = AuthStorage();
  });

  group('AuthStorage Unit Tests', () {
    final testUser = UserModel(
      id: '1',
      firstName: 'Nouran',
      lastName: 'Samer',
      email: 'nouran@test.com',
      photo: 'photo_url',
      role: 'user',
      wishlist: ['item1', 'item2'],
    );

    test('saveToken & getToken', () async {
      await authStorage.saveToken('12345');
      final token = await authStorage.getToken();
      expect(token, '12345');
    });

    test('clearToken', () async {
      await authStorage.saveToken('12345');
      await authStorage.clearToken();
      final token = await authStorage.getToken();
      expect(token, null);
    });

    test('saveUser & getUser', () async {
      await authStorage.saveUser(testUser);
      final user = await authStorage.getUser();
      expect(user?.id, testUser.id);
      expect(user?.firstName, testUser.firstName);
      expect(user?.wishlist, testUser.wishlist);
    });

    test('clearUser', () async {
      await authStorage.saveUser(testUser);
      await authStorage.clearUser();
      final user = await authStorage.getUser();
      expect(user, null);
    });

    test('setRememberMe & getRememberMe', () async {
      await authStorage.setRememberMe(true);
      final remember = await authStorage.getRememberMe();
      expect(remember, true);
    });

    test('clearAll resets everything', () async {
      await authStorage.saveToken('token');
      await authStorage.saveUser(testUser);
      await authStorage.setRememberMe(true);

      await authStorage.clearAll();

      final token = await authStorage.getToken();
      final user = await authStorage.getUser();
      final remember = await authStorage.getRememberMe();

      expect(token, null);
      expect(user, null);
      expect(remember, false);
    });
  });
}
