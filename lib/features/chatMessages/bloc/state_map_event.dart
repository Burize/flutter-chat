import 'package:flutter_chat/shared/models/message.dart';
import 'package:flutter_chat/shared/utils/collections.dart';

import './namespace.dart';
import './state.dart';
import '../../../shared/bloc/events.dart';

class AuthMapEvents extends IMapEvent<ChatState, IChatEvent> {
  TMapEventToState<ChatState, IChatEvent> get mapEvent => (s, e) async* {
        final next = ChatState.fromState(s);

        if (e is ChangeConnectionStatus) {
          yield next..connectionStatus = e.payload;
          return;
        }

        if (e is NewMessage || e is SendedMessage) {
          IChatMessage newMessage = e.payload;
          if (next.messages.contains((IChatMessage message) => message.id == newMessage.id)) {
            return;
          }

          next.messages
            ..add(newMessage)
            ..sort();
          yield next;
          return;
        }

        if (e is NewMessages) {
          final allMessages = [next.messages, e.payload].expand((message) => message).toList();
          final uniqueMessages = uniqueById<IChatMessage>(allMessages);
          uniqueMessages.sort();
          yield next..messages = uniqueMessages;
          return;
        }

        if (e is LoadMembersSuccess) {
          yield next..members.addAll(e.payload);
          return;
        }
      };
}
