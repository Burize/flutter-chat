import 'dart:convert';

import 'package:flutter_chat/services/api/converters/chat_members.dart';
import 'package:flutter_chat/shared/models/chat_member.dart' as ChatMemberModel;

import '../http_actions.dart';
import './base_api.dart';

class ChatMember extends BaseApi {
  HttpActions _httpActions;
  ChatMember(HttpActions httpActions) {
    _httpActions = httpActions;
  }

  Future<List<ChatMemberModel.ChatMember>> loadUsers(List<String> ids) async {
    final response = await _httpActions.get(IMethodArgs(
      url: '/members/${jsonEncode(ids)}',
    ));

    throwExceptionIfInvalidStatusCode(response);
    return convertUserFromResponse(response.body);
  }
}
