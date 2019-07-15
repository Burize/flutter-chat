import 'package:flutter_chat/shared/bloc/communication.dart';

import '../../../shared/bloc/events.dart';
import './namespace.dart';
import './state.dart';

class AuthMapEvents extends IMapEvent<AuthState, IAuthEvents> {
  TMapEventToState<AuthState, IAuthEvents> get mapEvent => (s, e) async* {
        final next = AuthState.fromState(s);

        if (e is Authenticate) {
          yield next..authenticating = ICommunication<String>.execute();
          return;
        }

        if (e is AuthenticateSuccess) {
          yield next..authenticating = ICommunication<String>.complete();
          return;
        }

        if (e is AuthenticateFail) {
          yield next..authenticating = ICommunication<String>.fail(e.payload);
          return;
        }
      };
}
