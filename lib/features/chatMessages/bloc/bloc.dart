import 'package:flutter/widgets.dart';

import '../../../core/dependency.dart';
import '../../../shared/bloc/events.dart';
import '../../../services/api/api.dart';

import './namespace.dart';
import './state.dart';
import './state_map_event.dart';

class AuthBloc extends IFeatureBloc<IAuthEvents, AuthState, AuthMapEvents> {
  final AuthState _initialState = AuthState.initial();
  AuthState get initialState => _initialState;

  final AuthMapEvents _mapEvent = AuthMapEvents();
  AuthMapEvents get mapEvent => _mapEvent;

  BuildContext replacementContext;

  Future<void> authenticate() async {
    try {
      dispatch(Authenticate());
      final api = DI.get<Api>();
      await api.user.authenticate();
      dispatch(AuthenticateSuccess());
    } catch (e) {
      dispatch(AuthenticateFail(e.msg));
    }
  }
}
