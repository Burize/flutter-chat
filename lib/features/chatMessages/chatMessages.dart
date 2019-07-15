import 'bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/core/dependency.dart';

import './view/containers/messages.dart';

class ChatMessages {
  // AuthBloc _bloc;

  ChatMessages() {
    // _bloc = DI.get<AuthBloc>();
  }

  Widget chatView() {
    return Messages();
  }
}
