import 'package:flutter_chat/core/config/api_host_config.dart';

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
      ),
    );
    user = User(_httpActions);
    chatMember = ChatMember(_httpActions);
  }

  String _getApiHost() {
    return ApiHostConfig.apiHost;
  }
}
