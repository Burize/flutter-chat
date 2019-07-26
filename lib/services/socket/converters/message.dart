import 'dart:convert';

import 'package:flutter_chat/shared/models/message.dart';

import '../namespace.dart';

IMessageEvent convertMessageEvent(String data) {
  final json = Map<String, dynamic>.from(jsonDecode(data));

  final messageType = convertMessageType(json['type']);

  final Map<EMessageType, Function> converterByEventType = {
    EMessageType.allMessages: convertChatMessageList,
    EMessageType.newMessage: convertNewMessageEvent,
  };

  return converterByEventType[messageType](json['payload']);
}

AllMessagesEvent convertChatMessageList(List<dynamic> json) {
  final messages = json.map(convertChatMessage).toList();
  return AllMessagesEvent(messages: messages);
}

NewMessageEvent convertNewMessageEvent(Map<String, dynamic> json) {
  return NewMessageEvent(message: convertChatMessage(json));
}

IChatMessage convertChatMessage(dynamic json) {
  return IChatMessage(
    id: json['id'],
    createdAt: json['createdAt'],
    body: json['body'],
    userId: json['userId'],
  );
}

EMessageType convertMessageType(String type) {
  Map<String, EMessageType> map = {
    'all_messages': EMessageType.allMessages,
    'new_message': EMessageType.newMessage,
  };

  final messageType = map[type];

  if (messageType == null) {
    throw 'Incorrect status while converting for request! AccessLevel not recognized: $messageType';
  }

  return messageType;
}

String convertMessageToEvent(EMessageType type, IChatMessage message) {
  final eventByType = {
    EMessageType.allMessages: 'all_messages',
    EMessageType.newMessage: 'new_message',
  };
  return jsonEncode({'type': eventByType[type], 'payload': convertMessageToResponse(message)});
}

Map<String, dynamic> convertMessageToResponse(IChatMessage message) => {
      'id': message.id,
      'userId': message.userId,
      'body': message.body,
      'createdAt': message.createdAt,
    };
