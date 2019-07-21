import 'package:flutter_chat/features/chatMessages/bloc/externals.dart' as chatContract;
import 'package:flutter_chat/services/socket/namespace.dart';
import 'package:flutter_chat/services/socket/socket_manager.dart';
import 'package:flutter_chat/shared/models/message.dart';

import '../dependency.dart';

class MessageManagerContract with chatContract.IChatMessageManagerContract {
  SocketManager _messageManager;

  List<IMessageEvent> get messages => _messageManager.messages;

  MessageManagerContract() {
    _messageManager = DI.get<SocketManager>();
  }

  chatContract.TUnsubscribe subscribe(chatContract.TSubscription handler) {
    return _messageManager.subscribe(handler);
  }

  void sendMessage(IChatMessage message) {
    return _messageManager.sendMessage(message);
  }
}
