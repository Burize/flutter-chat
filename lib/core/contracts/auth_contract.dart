import 'package:flutter_chat/features/auth/bloc/bloc.dart';
import 'package:flutter_chat/setup.dart' as setupAuthContract;

import '../dependency.dart';

class AuthContract with setupAuthContract.ISetupAuthContract {
  AuthBloc _auth;

  AuthContract() {
    _auth = DI.get<AuthBloc>();
  }

  @override
  Future<bool> checkAuth() {
    return _auth.checkAuth();
  }
}
