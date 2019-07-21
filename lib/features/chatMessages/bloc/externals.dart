import 'package:flutter_chat/services/socket/namespace.dart';
import 'package:flutter_chat/shared/models/message.dart'; // TODO: import from more top level

typedef void TSubscription(IMessageEvent message);
typedef void TUnsubscribe();

abstract class IChatMessageManagerContract {
  List<IMessageEvent> get messages;
  TUnsubscribe subscribe(TSubscription hanlder);
  void sendMessage(IChatMessage message);
}
