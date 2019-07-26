import 'package:flutter/material.dart';
import 'package:flutter_chat/services/api/api.dart';
import 'package:flutter_chat/services/storage/storage.dart';
import 'package:flutter_chat/shared/models/user.dart'; // TODO: MAKE CONTRACT

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
    await _storage.saveUser(user);
  }
  // Future<User> loadUser() async {
  //   User user = await _api.user.loadUser();
  //  //  await _saveUser(user);
  //   return user;
  // }

}
