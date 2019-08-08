import 'package:flutter_chat/core/config/api_host_config.dart';
import 'package:flutter_chat/core/service_locator.dart';
import 'package:flutter_chat/services/storage/storage.dart';

import './http_actions.dart';

import './entities/user.dart';
import './entities/chat_member.dart';

class Api {
  HttpActions _httpActions;
  User user;
  ChatMember chatMember;

  Api() {
    _httpActions = HttpActions(
      IOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        getApiHost: this._getApiHost,
        getPrivateHeaders: this._getPrivateHeaders,
      ),
    );
    user = User(_httpActions);
    chatMember = ChatMember(_httpActions);
  }

  String _getApiHost() {
    return ApiHostConfig.apiHost;
  }

  Future<Map<String, String>> _getPrivateHeaders() async {
    final storage = SL.get<Storage>();

    final authToken = await storage.getAuthToken();

    if (authToken == null) {
      throw Exception('there is no token for auth request');
    }

    return {'Authorization': 'Bearer $authToken'};
  }
}
