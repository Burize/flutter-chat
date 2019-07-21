import 'package:flutter_chat/services/socket/namespace.dart';

import './externals.dart';
import './namespace.dart';
import './state.dart';
import './state_map_event.dart';

import '../../../core/dependency.dart';
import '../../../shared/bloc/events.dart';
import '../../../shared/models/message.dart';

class ChatBloc extends IFeatureBloc<IChatEvents, ChatState, AuthMapEvents> {
  final ChatState _initialState = ChatState.initial();
  ChatState get initialState => _initialState;

  final AuthMapEvents _mapEvent = AuthMapEvents();
  AuthMapEvents get mapEvent => _mapEvent;

  IChatMessageManagerContract messageManager;

  ChatBloc() {
    messageManager = DI.get<IChatMessageManagerContract>();
    messageManager.subscribe(_onNewMessage);
  }

  Future<void> _onNewMessage(IMessageEvent event) async {
    if (event is AllMessagesEvent) {
      dispatch(NewMessages(event.messages));
    }

    if (event is NewMessageEvent) {
      dispatch(NewMessage(event.message));
    }
  }

  sendMessage(String messageBody) {
    final message = IChatMessage(
      body: messageBody,
      id: 'messageId',
      userId: 'ownId',
      createdAt: new DateTime.now().millisecondsSinceEpoch,
    );
    messageManager.sendMessage(message);
  }
}
