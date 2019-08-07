import './namespace.dart';
import '../../../services/socket/namespace.dart';
import '../../../shared/models/chat_member.dart';
import '../../../shared/models/message.dart';

final unknownMember = ChatMember(id: '-1', firstName: 'unknown', secondName: 'user');

class ChatState implements IChatState {
  List<IChatMessage> messages;
  List<ChatMember> members;
  EConnectionStatus connectionStatus;

  ChatState.fromState(ChatState state) {
    messages = state.messages;
    members = state.members;
    connectionStatus = state.connectionStatus;
  }

  ChatState.initial() {
    messages = [];
    members = [];
    connectionStatus = EConnectionStatus.pending;
  }
}
