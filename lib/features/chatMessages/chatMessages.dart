import 'bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/core/dependency.dart';

import './view/containers/messages_list.dart';

class ChatMessages {
  ChatBloc _bloc;

  ChatMessages() {
    _bloc = DI.get<ChatBloc>();
  }

  Widget chatView() {
    return MessagesList(bloc: _bloc);
  }
}
