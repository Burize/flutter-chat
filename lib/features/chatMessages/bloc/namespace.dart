import '../../../shared/bloc/events.dart';

class Message {
  String body;

  Message({this.body});
}

abstract class IChatState {
  List<Message> messages;
}

abstract class IChatEvents<P> extends IAction<P> {
  IChatEvents(P payload) : super(payload);
}

class NewMessage extends IChatEvents<Message> {
  NewMessage(Message message) : super(message);
}
