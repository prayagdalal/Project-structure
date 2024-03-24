import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _preferences;

  static const String _keyUsername = 'username';
  static const String _keyEmail = 'email';
  static const String _keyToken = 'token';

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<void> setUsername(String? username) async {
    await _preferences?.setString(_keyUsername, username ?? '');
  }

  static String? getUsername() => _preferences?.getString(_keyUsername);

  static Future<void> setEmail(String? email) async {
    await _preferences?.setString(_keyEmail, email ?? '');
  }

  static String? getEmail() => _preferences?.getString(_keyEmail);

  static Future<void> setToken(String? token) async {
    await _preferences?.setString(_keyToken, token ?? '');
  }

  static String? getToken() => _preferences?.getString(_keyToken);

  static Future<void> clear() async {
    await _preferences?.clear();
  }

  static Future<Map<String, dynamic>> getAll() async {
    final username = getUsername();
    final email = getEmail();
    final token = getToken();

    return {
      _keyUsername: username,
      _keyEmail: email,
      _keyToken: token,
    };
  }

  static Future<String?> getJson() async {
    final map = await getAll();
    return jsonEncode(map);
  }

  static Future<void> setFromJson(String? json) async {
    if (json == null) {
      return;
    }

    final map = jsonDecode(json) as Map<String, dynamic>;
    await setUsername(map[_keyUsername]);
    await setEmail(map[_keyEmail]);
    await setToken(map[_keyToken]);
  }
}
