import 'dart:async';

import './namespace.dart';
import './state.dart';
import './state_map_event.dart';
import '../../../core/core.dart';
import '../../../core/service_locator.dart';
import '../../../services/api/api.dart';
import '../../../services/api/errors/errors.dart';
import '../../../services/storage/storage.dart';
import '../../../services/user/user_manager.dart';
import '../../../shared/bloc/events.dart';
import '../../../shared/models/user.dart';

class AuthBloc extends IFeatureBloc<IAuthEvents, AuthState, AuthMapEvents> {
  final AuthState _initialState = AuthState.initial();
  AuthState get initialState => _initialState;

  final AuthMapEvents _mapEvent = AuthMapEvents();
  AuthMapEvents get mapEvent => _mapEvent;

  Future<bool> checkAuth() async {
    final userManager = SL.get<UserManager>();
    return userManager.checkUserIsAuth();
  }

  Future<bool> authenticate(String phone, String password) async {
    try {
      dispatch(Authenticate());
      final api = SL.get<Api>();
      final user = await api.user.authenticate(phone, password);
      await _saveUser(user);
      dispatch(AuthenticateSuccess());
      return true;
    } catch (e) {
      dispatch(AuthenticateFail(e is ApiError ? e.message : e.toString()));
      return false;
    }
  }

  Future<bool> registrate(String firstName, String secondName, String phone, String password) async {
    try {
      dispatch(Registrate());
      final api = SL.get<Api>();
      final user = await api.user.registration(IMainUserFields(
        firstName: firstName,
        secondName: secondName,
        phone: phone,
        password: password,
      ));

      await _saveUser(user);
      dispatch(RegistrateSuccess());
      return true;
    } catch (e) {
      dispatch(RegistrateFail(e is ApiError ? e.message : e.toString()));
      return false;
    }
  }

  Future<void> _saveUser(User user) async {
    final userManager = SL.get<UserManager>();
    await userManager.authorize();
    await userManager.saveUser(user);
  }

  Future<void> logout() async {
    Storage storage = SL.get<Storage>();
    await storage.removeUser();
    await storage.removeIsAuthotized();
    await Core.clearDependencies();
  }
}
