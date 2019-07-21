import '../../../shared/bloc/events.dart';
import 'package:flutter_chat/shared/models/message.dart';

abstract class IChatState {
  List<IChatMessage> messages;
}

abstract class IChatEvents<P> extends IAction<P> {
  IChatEvents(P payload) : super(payload);
}

class NewMessage extends IChatEvents<IChatMessage> {
  NewMessage(IChatMessage message) : super(message);
}

class NewMessages extends IChatEvents<List<IChatMessage>> {
  NewMessages(List<IChatMessage> messages) : super(messages);
}
