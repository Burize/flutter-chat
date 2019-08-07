import 'package:flutter_chat/features/chatMessages/bloc/externals.dart' as chatContract;
import 'package:flutter_chat/services/socket/namespace.dart';
import 'package:flutter_chat/services/socket/socket_manager.dart';
import 'package:flutter_chat/shared/models/message.dart';

import '../service_locator.dart';

class MessageManagerContract with chatContract.IChatMessageManagerContract {
  SocketManager _messageManager;

  List<IMessageEvent> get messages => _messageManager.messages;

  MessageManagerContract() {
    _messageManager = SL.get<SocketManager>();
  }

  chatContract.TUnsubscribe subscribe(chatContract.TSubscription handler) {
    return _messageManager.subscribe(handler);
  }

  chatContract.TUnsubscribe onConnectionChange(chatContract.TConnectionStatusSubscription handler) {
    return _messageManager.onConnectionChange(handler);
  }

  void sendMessage(IChatMessage message) {
    return _messageManager.sendMessage(message);
  }
}
