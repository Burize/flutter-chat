import 'package:flutter_chat/shared/bloc/communication.dart';

import '../../../shared/bloc/events.dart';

abstract class IAuthState {
  ICommunication<String> authenticating;
}

abstract class IAuthEvents<P> extends IAction<P> {
  IAuthEvents(P payload) : super(payload);
}

class Authenticate extends IAuthEvents {
  Authenticate() : super(null);
}

class AuthenticateSuccess extends IAuthEvents {
  AuthenticateSuccess() : super(null);
}

class AuthenticateFail extends IAuthEvents<String> {
  AuthenticateFail(String error) : super(error);
}
