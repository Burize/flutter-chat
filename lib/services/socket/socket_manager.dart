import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/config/api_host_config.dart';
import '../../shared/models/message.dart';
import 'converters/message.dart';
import 'namespace.dart';

typedef void TMessageEventSubscription(IMessageEvent event);
typedef void TConnectionStatusSubscription(EConnectionStatus event);
typedef void Tunsubscribe();

final connectTimeout = Duration(seconds: 2);

class SocketManager {
  IOWebSocketChannel _channel;
  PublishSubject<IMessageEvent> _messages$ = PublishSubject<IMessageEvent>();
  BehaviorSubject<EConnectionStatus> _connectionStatus$ =
      BehaviorSubject<EConnectionStatus>.seeded(EConnectionStatus.pending);

  List<IMessageEvent> _messages = [];
  List<IMessageEvent> get messages => _messages;

  initialize() async {
    await _connect();
  }

  _connect() async {
    try {
      final socket = await WebSocket.connect(_getSocketHost()).timeout(connectTimeout);

      _channel = IOWebSocketChannel(socket);
      _channel.stream.listen(_onReceiveMessage, onDone: _onCloseConnection);
      _channel.stream.handleError(_onError);
      _changeConnectionStatus(EConnectionStatus.connected);
    } catch (error) {
      _changeConnectionStatus(EConnectionStatus.error);
      _reconnect();
    }
  }

  _onCloseConnection() {
    _reconnect();
  }

  _onError(WebSocketChannelException _error) {
    print('WebSocket error: ${_error.toString()}');
  }

  _reconnect() {
    Timer(Duration(seconds: 5), _connect);
  }

  _onReceiveMessage(event) {
    final messageEvent = convertMessageEvent(event);
    _messages.add(messageEvent);
    _messages$.add(messageEvent);
  }

  _changeConnectionStatus(EConnectionStatus status) {
    final currentConnectionStatus = _connectionStatus$.value;
    if (currentConnectionStatus != status) {
      _connectionStatus$.add(status);
    }
  }

  Tunsubscribe subscribe(TMessageEventSubscription handler) {
    final subscribtion = _messages$.listen(handler);
    return () {
      subscribtion.cancel();
    };
  }

  Tunsubscribe onConnectionChange(TConnectionStatusSubscription handler) {
    final subscribtion = _connectionStatus$.listen(handler);
    return () {
      subscribtion.cancel();
    };
  }

  sendMessage(IChatMessage message) {
    final newMessageEvent = convertMessageToEvent(EMessageType.newMessage, message);
    _channel.sink.add(newMessageEvent);
  }

  String _getSocketHost() {
    return ApiHostConfig.socketHost;
  }
}
