import 'package:flutter/material.dart';
import 'package:flutter_chat/features/auth/bloc/namespace.dart';

import './view/containers/sign_in_form.dart';
import './view/containers/sign_up_form.dart';
import '../../core/dependency.dart';
import './bloc/bloc.dart';

class Auth {
  AuthBloc _bloc;

  Auth() {
    _bloc = DI.get<AuthBloc>();
  }

  Widget signInForm(TOnAuthenticate onAuthenticate) {
    return SignInForm(bloc: _bloc);
  }

  Widget signUpForm(TOnAuthenticate onAuthenticate) {
    return SignUpForm(bloc: _bloc);
  }
}
