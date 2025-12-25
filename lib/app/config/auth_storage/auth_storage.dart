import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flower_shop/features/auth/domain/models/user_model.dart';

@lazySingleton
class AuthStorage {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'user_data';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode({
      'id': user.id,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'photo': user.photo,
      'role': user.role,
      'wishlist': user.wishlist,
    });
    await prefs.setString(_userKey, userJson);
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString == null) return null;

    final Map<String, dynamic> json = jsonDecode(userString);
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      photo: json['photo'],
      role: json['role'],
      wishlist: json['wishlist']?.cast<dynamic>(),
    );
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<void> clearAll() async {
    await clearToken();
    await clearUser();
  }
}
