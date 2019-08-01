import './namespace.dart';
import '../../../shared/models/chat_member.dart';
import '../../../shared/models/message.dart';

final unknownMember = ChatMember(id: '-1', firstName: 'unknown', secondName: 'user');

final messageMocks = [
  IChatMessage(body: 'ok', createdAt: 1563625091653, id: '1', userId: '5d35bdec5f7e86c804e4fe68'),
  IChatMessage(
      body:
          'large message large messagelarge messagelarge messagelarge messagelarge messagelarge messagelarge message biiiiiiiiiiiiiiiiiiiiiig word large messagelarge message ',
      createdAt: 1563625091653,
      id: '2',
      userId: '5d35b90b5f7e86c804e4fe65'),
  IChatMessage(body: 'my own message ', createdAt: 1563625091653, id: '1', userId: '2'),
  IChatMessage(
      body:
          'large message large messagelarge messagelarge messagelarge messagelarge messagelarge messagelarge message biiiiiiiiiiiiiiiiiiiiiig word large messagelarge message ',
      createdAt: 1563625091653,
      id: '3',
      userId: '2'),
  IChatMessage(body: 'ok', createdAt: 1563625091653, id: '4', userId: '5d35b9ea5f7e86c804e4fe67'),
];

class ChatState implements IChatState {
  List<IChatMessage> messages;
  List<ChatMember> members;

  ChatState.fromState(ChatState state) {
    messages = state.messages;
    members = state.members;
  }

  ChatState.initial() {
    messages = [];
    members = [];
  }
}
