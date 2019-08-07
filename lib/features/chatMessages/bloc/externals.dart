import '../../../services/socket/namespace.dart';
import '../../../shared/models/message.dart';

typedef void TSubscription(IMessageEvent message);
typedef void TConnectionStatusSubscription(EConnectionStatus status);

typedef void TUnsubscribe();

abstract class IChatMessageManagerContract {
  List<IMessageEvent> get messages;

  TUnsubscribe subscribe(TSubscription hanlder);
  void sendMessage(IChatMessage message);
  void onConnectionChange(TConnectionStatusSubscription handler);
}
