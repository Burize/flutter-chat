import './namespace.dart';

class ChatState implements IChatState {
  List<Message> messages;

  ChatState.fromState(ChatState state) {
    messages = state.messages;
  }

  ChatState.initial() {
    messages = [];
  }
}
