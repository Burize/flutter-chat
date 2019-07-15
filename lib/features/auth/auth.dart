import 'bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/core/dependency.dart';

import './view/containers/sign_in_form.dart';

class Auth {
  AuthBloc _bloc;

  Auth() {
    _bloc = DI.get<AuthBloc>();
  }

  Widget signInForm() {
    return SignInForm(bloc: _bloc);
  }
}
