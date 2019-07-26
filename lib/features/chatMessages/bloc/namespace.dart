import 'package:flutter_chat/shared/models/chat_member.dart';

import '../../../shared/bloc/events.dart';
import 'package:flutter_chat/shared/models/message.dart';

abstract class IChatState {
  List<IChatMessage> messages;
  List<ChatMember> members;
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

class LoadMembers extends IChatEvents {
  LoadMembers() : super(null);
}

class LoadMembersSuccess extends IChatEvents<List<ChatMember>> {
  LoadMembersSuccess(List<ChatMember> members) : super(members);
}

class LoadMembersFail extends IChatEvents<String> {
  LoadMembersFail(String error) : super(error);
}
