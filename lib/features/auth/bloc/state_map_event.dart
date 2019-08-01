import './namespace.dart';
import './state.dart';
import '../../../shared/bloc/communication.dart';
import '../../../shared/bloc/events.dart';

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

        if (e is Registrate) {
          yield next..registrating = ICommunication<String>.execute();
          return;
        }

        if (e is RegistrateSuccess) {
          yield next..registrating = ICommunication<String>.complete();
          return;
        }

        if (e is RegistrateFail) {
          yield next..registrating = ICommunication<String>.fail(e.payload);
          return;
        }
      };
}
