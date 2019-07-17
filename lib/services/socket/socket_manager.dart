import 'dart:async';

import 'package:flutter_chat/core/config/api_host_config.dart';
import 'package:web_socket_channel/io.dart';

typedef void TSubscription(String message);
typedef void Tunsubscribe();

class SocketManager {
  IOWebSocketChannel _channel;
  List<TSubscription> _subscription = [];

  List<String> _messages = [];
  List<String> get messages => _messages;

  SocketManager() {
    _channel = IOWebSocketChannel.connect(_getSocketHost());
    _channel.stream.listen(_onReceiveMessage);

    Timer.periodic(new Duration(seconds: 2), (timer) {
      _channel.sink.add('test message');
    });
  }

  _onReceiveMessage(message) {
    _messages.add(message);
    _subscription.forEach((hanlder) => hanlder(message));
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
