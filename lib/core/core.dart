import '../features/auth/bloc/bloc.dart';

import '../services/api/api.dart';

import './dependency.dart';

class Core {
  static bool _isDependenciesLoaded = false;

  static get isDependenciesLoaded => _isDependenciesLoaded;

  static Future<void> makeCore() async {
    await _makeDependenciesInjector();
  }

  static Future<void> _makeDependenciesInjector() async {
    DI.makeDependency<Api>(() => Api());

    DI.makeDependency<AuthBloc>(() => AuthBloc());
  }
}
