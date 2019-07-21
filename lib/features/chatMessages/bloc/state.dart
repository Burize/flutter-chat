import 'package:flutter_chat/shared/models/message.dart';

import './namespace.dart';

final messageMocks = [
  IChatMessage(body: 'ok', createdAt: 1563625091653, id: '1', userId: '1'),
  IChatMessage(
      body:
          'large message large messagelarge messagelarge messagelarge messagelarge messagelarge messagelarge message biiiiiiiiiiiiiiiiiiiiiig word large messagelarge message ',
      createdAt: 1563625091653,
      id: '2',
      userId: '1'),
  IChatMessage(body: 'my own message ', createdAt: 1563625091653, id: '1', userId: '2'),
  IChatMessage(
      body:
          'large message large messagelarge messagelarge messagelarge messagelarge messagelarge messagelarge message biiiiiiiiiiiiiiiiiiiiiig word large messagelarge message ',
      createdAt: 1563625091653,
      id: '3',
      userId: '2'),
  IChatMessage(body: 'ok', createdAt: 1563625091653, id: '4', userId: '1'),
];

class ChatState implements IChatState {
  List<IChatMessage> messages;

  ChatState.fromState(ChatState state) {
    messages = state.messages;
  }

  ChatState.initial() {
    messages = [];
  }
}
