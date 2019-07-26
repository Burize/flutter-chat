import 'package:flutter/widgets.dart';
import 'package:flutter_chat/shared/bloc/communication.dart';

import '../../../shared/bloc/events.dart';

typedef void TOnAuthenticate(BuildContext context);

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

class Registrate extends IAuthEvents {
  Registrate() : super(null);
}

class RegistrateSuccess extends IAuthEvents {
  RegistrateSuccess() : super(null);
}

class RegistrateFail extends IAuthEvents<String> {
  RegistrateFail(String error) : super(error);
}
