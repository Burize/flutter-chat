import 'dart:convert';

import 'package:flutter_chat/shared/models/user.dart';

Map<String, dynamic> convertUserToResponse(IMainUserFields user) => {
      'firstName': user.firstName,
      'secondName': user.secondName,
      'phone': user.phone,
      'password': user.password,
    };

User convertUserFromResponse(String json) {
  final rawUser = jsonDecode(json);
  return User(
    id: rawUser['id'],
    firstName: rawUser['firstName'],
    secondName: rawUser['secondName'],
    phone: rawUser['phone'],
    password: rawUser['password'],
  );
}

Map<String, dynamic> convertAuthFieldsToResponse(String phone, String password) => {
      'phone': phone,
      'password': password,
    };
