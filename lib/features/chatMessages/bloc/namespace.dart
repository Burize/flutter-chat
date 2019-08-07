import 'package:flutter_chat/services/socket/namespace.dart';

import '../../../shared/bloc/events.dart';
import '../../../shared/models/chat_member.dart';
import '../../../shared/models/message.dart';

abstract class IChatState {
  List<IChatMessage> messages;
  List<ChatMember> members;
  EConnectionStatus connectionStatus;
}

abstract class IChatEvent<P> extends IAction<P> {
  IChatEvent(P payload) : super(payload);
}

class SendedMessage extends IChatEvent<IChatMessage> {
  SendedMessage(IChatMessage message) : super(message);
}

class NewMessage extends IChatEvent<IChatMessage> {
  NewMessage(IChatMessage message) : super(message);
}

class ChangeConnectionStatus extends IChatEvent<EConnectionStatus> {
  ChangeConnectionStatus(EConnectionStatus status) : super(status);
}

class NewMessages extends IChatEvent<List<IChatMessage>> {
  NewMessages(List<IChatMessage> messages) : super(messages);
}

class LoadMembers extends IChatEvent {
  LoadMembers() : super(null);
}

class LoadMembersSuccess extends IChatEvent<List<ChatMember>> {
  LoadMembersSuccess(List<ChatMember> members) : super(members);
}

class LoadMembersFail extends IChatEvent<String> {
  LoadMembersFail(String error) : super(error);
}
