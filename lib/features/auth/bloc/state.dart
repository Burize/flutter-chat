import './namespace.dart';
import '../../../shared/bloc/communication.dart';

class AuthState implements IAuthState {
  ICommunication<String> authenticating;
  ICommunication<String> registrating;

  AuthState.fromState(AuthState state) {
    authenticating = state.authenticating;
    registrating = state.registrating;
  }

  AuthState.initial() {
    authenticating = ICommunication<String>.initial();
    registrating = ICommunication<String>.initial();
  }
}
