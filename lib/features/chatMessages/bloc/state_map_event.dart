import './namespace.dart';
import './state.dart';
import '../../../shared/bloc/events.dart';

class AuthMapEvents extends IMapEvent<ChatState, IChatEvent> {
  TMapEventToState<ChatState, IChatEvent> get mapEvent => (s, e) async* {
        final next = ChatState.fromState(s);

        if (e is NewMessage || e is SendedMessage) {
          yield next..messages.add(e.payload);
          return;
        }

        if (e is NewMessages) {
          yield next..messages.addAll(e.payload);
          return;
        }

        if (e is LoadMembersSuccess) {
          yield next..members.addAll(e.payload);
          return;
        }
      };
}
