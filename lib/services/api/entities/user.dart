import 'package:flutter_chat/services/api/converters/user.dart';
import 'package:flutter_chat/shared/models/user.dart' as UserModel;

import '../http_actions.dart';
import './base_api.dart';
// import '../converters/city.dart';

class User extends BaseApi {
  HttpActions _httpActions;
  User(HttpActions httpActions) {
    _httpActions = httpActions;
  }

  Future<UserModel.User> authenticate(String phone, String password) async {
    final response = await _httpActions.post(IMethodArgs(
      url: '/auth',
      data: convertAuthFieldsToResponse(phone, password),
    ));

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }

  Future<UserModel.User> registration(UserModel.IMainUserFields user) async {
    final response = await _httpActions.post(IMethodArgs(
      url: '/user/',
      data: convertUserToResponse(user),
    ));

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }
}
