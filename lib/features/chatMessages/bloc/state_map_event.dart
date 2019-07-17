import '../../../shared/bloc/events.dart';
import './namespace.dart';
import './state.dart';

class AuthMapEvents extends IMapEvent<ChatState, IChatEvents> {
  TMapEventToState<ChatState, IChatEvents> get mapEvent => (s, e) async* {
        final next = ChatState.fromState(s);

        if (e is NewMessage) {
          yield next..messages.add(e.payload);
          return;
        }
      };
}
