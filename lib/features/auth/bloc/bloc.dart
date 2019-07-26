import 'package:flutter/widgets.dart';
import 'package:flutter_chat/services/user/user_manager.dart';
import 'package:flutter_chat/shared/models/user.dart';

import '../../../core/dependency.dart';
import '../../../shared/bloc/events.dart';
import '../../../services/api/api.dart';

import './namespace.dart';
import './state.dart';
import './state_map_event.dart';

typedef void TOnAuthenticateSuccess();

class AuthBloc extends IFeatureBloc<IAuthEvents, AuthState, AuthMapEvents> {
  TOnAuthenticateSuccess onAuthenticate;

  final AuthState _initialState = AuthState.initial();
  AuthState get initialState => _initialState;

  final AuthMapEvents _mapEvent = AuthMapEvents();
  AuthMapEvents get mapEvent => _mapEvent;

  BuildContext replacementContext;

  Future<bool> checkAuth() async {
    final userManager = DI.get<UserManager>();
    return userManager.checkUserIsAuth();
  }

  Future<void> authenticate(String phone, String password) async {
    try {
      dispatch(Authenticate());
      final api = DI.get<Api>();
      final user = await api.user.authenticate(phone, password);
      final userManager = DI.get<UserManager>();
      await userManager.authorize();
      await userManager.saveUser(user);
      dispatch(AuthenticateSuccess());
      onAuthenticate();
    } catch (e) {
      dispatch(AuthenticateFail(e.msg));
    }
  }

  Future<void> registrate(String firstName, String secondName, String phone, String password) async {
    try {
      dispatch(Registrate());
      final api = DI.get<Api>();
      final user = await api.user.registration(
          IMainUserFields(firstName: firstName, secondName: secondName, phone: phone, password: password));
      dispatch(RegistrateSuccess());
    } catch (e) {
      dispatch(RegistrateFail(e.msg));
    }
  }
}
