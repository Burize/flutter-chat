import 'package:flutter/material.dart';
import 'package:flutter_chat/features/auth/bloc/namespace.dart';

import './view/containers/sign_in_form.dart';
import './view/containers/sign_up_form.dart';
import '../../core/service_locator.dart';
import './bloc/bloc.dart';

class Auth {
  AuthBloc _bloc;

  Auth() {
    _bloc = SL.get<AuthBloc>();
  }

  Widget signInForm(TOnAuthenticate onAuthenticate) {
    return SignInForm(bloc: _bloc, onAuthenticate: onAuthenticate);
  }

  Widget signUpForm(TOnRegistrate onRegistrate) {
    return SignUpForm(bloc: _bloc, onRegistrate: onRegistrate);
  }
}
