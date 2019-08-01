import 'dart:convert';

import '../../../shared/models/user.dart';

Map<String, dynamic> convertUserToResponse(IMainUserFields user) => {
      'firstName': user.firstName,
      'secondName': user.secondName,
      'phone': user.phone,
      'password': user.password,
    };

User convertUserFromResponse(String json) {
  final jsonUser = jsonDecode(json);
  return User.fromJson(jsonUser);
}

Map<String, dynamic> convertAuthFieldsToResponse(String phone, String password) => {
      'phone': phone,
      'password': password,
    };

Map<String, dynamic> convertUpdateUserToResponse({String firstName, String secondName, String phone}) {
  final fieldsForUpdate = {
    'firstName': firstName,
    'secondName': secondName,
    'phone': phone,
  };
  fieldsForUpdate.removeWhere((key, value) => value == null);

  return fieldsForUpdate;
}

String convertUserAvatarFromResponse(String json) {
  final jsonResponse = jsonDecode(json);
  return jsonResponse['avatar'];
}
