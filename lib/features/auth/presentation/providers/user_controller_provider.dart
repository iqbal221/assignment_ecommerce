import 'dart:convert';
import 'package:ecommerce_assignment_module_31/features/auth/data/modules/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const _tokenKey = "access-token";
  static const _userKey = "user-data";

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(String token, UserModel model) async {
    // Implementation to save user data
    SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
    await sharedPrefereces.setString(_tokenKey, token);
    await sharedPrefereces.setString(_userKey, jsonEncode(model.toJson()));

    accessToken = token;
    userModel = model;
  }

  static Future<void> getUserData() async {
    // Implementation to load user data
    SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
    String? accessToken = sharedPrefereces.getString(_tokenKey);

    if (accessToken != null) {
      final String? userData = sharedPrefereces.getString(_userKey);
      if (userData != null) {
        userModel = UserModel.fromJson(jsonDecode(userData));
      }
    }
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
    return sharedPrefereces.getString(_tokenKey) != null;
  }

  static Future<void> clearUserData() async {
    // Implementation to clear user data
    SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
    await sharedPrefereces.clear();
  }
}
