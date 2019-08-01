import '../../shared/models/message.dart';

enum EMessageType {
  allMessages,
  newMessage,
  sendedMessage,
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

class SendedMessageEvent extends IMessageEvent {
  final EMessageType eventType = EMessageType.sendedMessage;
  final IChatMessage message;

  SendedMessageEvent({this.message});
}
