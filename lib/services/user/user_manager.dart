import 'package:flutter/material.dart';

import '../../shared/models/user.dart';
import '../api/api.dart';
import '../storage/storage.dart';

class UserManager {
  final Storage _storage;
  final Api _api;
  User _user;

  UserManager({@required Storage storage, @required Api api})
      : _storage = storage,
        _api = api;

  initialize() async {
    _user = await _storage.getUser();
  }

  User get user {
    if (_user == null) {
      throw Exception('UserService not initialized');
    }
    return _user;
  }

  Future<void> authorize() async {
    return _storage.setIsAuthotized(true);
  }

  Future<bool> checkUserIsAuth() async {
    return _storage.getIsAuthotized();
  }

  saveUser(User user) async {
    _user = user;
    await _storage.saveUser(user);
  }

  Future<void> updateUser() async {
    if (_user == null) {
      throw Exception('Try update nonexistent user');
    }

    User lastUser = await _api.user.loadUser(_user.id);
    await saveUser(lastUser);
    _user = lastUser;
  }
}
