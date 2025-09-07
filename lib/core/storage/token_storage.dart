import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenStorage {
  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clear();
}

class SharedPrefsTokenStorage implements TokenStorage {
  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';

  @override
  Future<void> saveAccessToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kAccess, token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kRefresh, token);
  }

  @override
  Future<String?> getAccessToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kAccess);
  }

  @override
  Future<String?> getRefreshToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_kRefresh);
  }

  @override
  Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kAccess);
    await sp.remove(_kRefresh);
  }
}
