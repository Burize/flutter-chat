import 'package:flutter_chat/shared/models/user.dart' as UserModel;

import './base_api.dart';
import '../converters/user.dart';
import '../http_actions.dart';

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

  Future<UserModel.User> loadUser(String userId) async {
    final response = await _httpActions.get(IMethodArgs(
      url: '/user/$userId', // TODO MAKE VIA TOKEN
    ));

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }

  Future<UserModel.User> updateUser(String userId, {String firstName, String secondName, String phone}) async {
    final response = await _httpActions.patch(IMethodArgs(
      url: '/user/$userId', // TODO MAKE VIA TOKEN,
      data: convertUpdateUserToResponse(firstName: firstName, secondName: secondName, phone: phone),
    ));

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }

  Future<String> updateUserAvatar(String userId, String avatar) async {
    final response = await _httpActions.patch(IMethodArgs(
      url: '/user/avatar/$userId', // TODO MAKE VIA TOKEN,
      data: {'avatar': avatar},
    ));

    throwExceptionIfInvalidStatusCode(response);

    return convertUserAvatarFromResponse(response.body);
  }
}
