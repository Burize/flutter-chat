import 'package:flutter_chat/shared/bloc/communication.dart';

import './namespace.dart';

class AuthState implements IAuthState {
  ICommunication<String> authenticating;

  AuthState.fromState(AuthState state) {
    authenticating = state.authenticating;
  }

  AuthState.initial() {
    authenticating = ICommunication<String>.initial();
  }
}
