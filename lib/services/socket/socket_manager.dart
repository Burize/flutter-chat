import 'package:flutter_chat/core/config/api_host_config.dart';
import 'package:flutter_chat/shared/models/message.dart';
import 'package:web_socket_channel/io.dart';

import 'converters/message.dart';
import 'namespace.dart';

typedef void TSubscription(IMessageEvent event);
typedef void Tunsubscribe();

class SocketManager {
  IOWebSocketChannel _channel;
  List<TSubscription> _subscription = [];

  List<IMessageEvent> _messages = [];
  List<IMessageEvent> get messages => _messages;

  SocketManager() {
    _channel = IOWebSocketChannel.connect(_getSocketHost());
    _channel.stream.listen(_onReceiveMessage);
  }

  _onReceiveMessage(event) {
    final messageEvent = convertMessageEvent(event);
    _messages.add(messageEvent);
    _subscription.forEach((hanlder) => hanlder(messageEvent));
  }

  sendMessage(IChatMessage message) {
    final newMessageEvent = convertMessageToEvent(EMessageType.newMessage, message);
    _channel.sink.add(newMessageEvent);
  }

  Tunsubscribe subscribe(TSubscription hanlder) {
    _subscription.add(hanlder);
    return () {
      _unsubscribe(hanlder);
    };
  }

  void _unsubscribe(TSubscription hanlder) {
    _subscription.remove(hanlder);
  }

  String _getSocketHost() {
    return ApiHostConfig.socketHost;
  }
}
