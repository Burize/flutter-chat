import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/models/user.dart';

typedef T TReadyStorageCallback<T>();

final keys = {
  'user': 'user',
  'isAuthorized': 'auth.isAuthorized',
  'authToken': 'auth.token',
};

class Storage {
  SharedPreferences _storage;
  Future<SharedPreferences> _initializing;

  Storage() {
    _initializing = SharedPreferences.getInstance().then((sp) => _storage = sp);
  }

  Future<User> getUser() async {
    await _initializing;
    final data = _storage.getString(keys['user']);

    if (data == null) {
      return null;
    }

    final json = jsonDecode(data);
    return User.fromJson(json);
  }

  Future<void> saveUser(User user) async {
    await _initializing;
    await _storage.setString(keys['user'], jsonEncode(user.toJson()));
  }

  Future<void> removeUser() async {
    await _initializing;
    await _storage.remove(keys['user']);
  }

  Future<void> removeIsAuthotized() async {
    await _initializing;
    await _storage.remove(keys['isAuthorized']);
  }

  Future<void> setIsAuthotized(bool isAuthorized) async {
    await _initializing;
    await _storage.setBool(keys['isAuthorized'], isAuthorized);
  }

  Future<bool> getIsAuthotized() async {
    await _initializing;
    final isAuthorized = _storage.getBool(keys['isAuthorized']);
    return isAuthorized ?? false;
  }

  Future<void> removeAuthToken() async {
    await _initializing;
    await _storage.remove(keys['authToken']);
  }

  Future<void> setAuthToken(String token) async {
    await _initializing;
    await _storage.setString(keys['authToken'], token);
  }

  Future<String> getAuthToken() async {
    await _initializing;
    return _storage.getString(keys['authToken']);
  }
}
