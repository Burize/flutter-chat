import 'package:flutter_chat/shared/models/user.dart' as UserModel;

import './base_api.dart';
import '../converters/user.dart';
import '../http_actions.dart';

class User extends BaseApi {
  HttpActions _httpActions;
  User(HttpActions httpActions) {
    _httpActions = httpActions;
  }

  Future<String> authenticate(String phone, String password) async {
    final response = await _httpActions.post(IMethodArgs(
      url: '/auth',
      data: convertAuthFieldsToResponse(phone, password),
      isNotProtected: true,
    ));

    throwExceptionIfInvalidStatusCode(response);
    return response.body; // token
  }

  Future<String> registration(UserModel.IRegistrationUserFields user) async {
    final response = await _httpActions.post(IMethodArgs(
      url: '/user',
      data: convertRegistrationFieldsToResponse(user),
      isNotProtected: true,
    ));

    throwExceptionIfInvalidStatusCode(response);
    return response.body; // token
  }

  Future<UserModel.User> loadAcount() async {
    final response = await _httpActions.get(
      IMethodArgs(
        url: '/user/me',
      ),
    );

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }

  Future<UserModel.User> loadUserById(String userId) async {
    final response = await _httpActions.get(IMethodArgs(url: '/user/$userId'));

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }

  Future<UserModel.User> updateUser(String userId, {String firstName, String secondName, String phone}) async {
    final response = await _httpActions.patch(IMethodArgs(
      url: '/user',
      data: convertUpdateUserToResponse(firstName: firstName, secondName: secondName, phone: phone),
    ));

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }

  Future<String> updateUserAvatar(String avatar) async {
    final response = await _httpActions.patch(IMethodArgs(
      url: '/user/avatar',
      data: {'avatar': avatar},
    ));

    throwExceptionIfInvalidStatusCode(response);

    return convertUserAvatarFromResponse(response.body);
  }
}
