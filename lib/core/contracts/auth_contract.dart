import 'package:flutter_chat/setup.dart' as setupAuthContract;

import '../../features/auth/bloc/bloc.dart';
import '../../modules/profile/view/profile.dart';
import '../dependency.dart';

class AuthContract with setupAuthContract.ISetupAuthContract, ILogoutAuthContract {
  AuthBloc _auth;

  AuthContract() {
    _auth = DI.get<AuthBloc>();
  }

  @override
  Future<bool> checkAuth() {
    return _auth.checkAuth();
  }

  @override
  Future<void> logout() {
    return _auth.logout();
  }
}
