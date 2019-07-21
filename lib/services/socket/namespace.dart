import 'package:flutter_chat/shared/models/message.dart';

enum EMessageType {
  allMessages,
  newMessage,
}

abstract class IMessageEvent {
  EMessageType eventType;
}

class AllMessagesEvent extends IMessageEvent {
  final EMessageType eventType = EMessageType.allMessages;
  final List<IChatMessage> messages;

  AllMessagesEvent({this.messages});
}

class NewMessageEvent extends IMessageEvent {
  final EMessageType eventType = EMessageType.allMessages;
  final IChatMessage message;

  NewMessageEvent({this.message});
}
