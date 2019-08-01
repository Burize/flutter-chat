import './dependency.dart';
import '../features/auth/bloc/bloc.dart';
import '../features/chatMessages/bloc/bloc.dart';
import '../features/chatMessages/bloc/externals.dart';
import '../features/profileOverview/bloc/bloc.dart';
import '../modules/profile/view/profile.dart';
import '../services/api/api.dart';
import '../services/socket/socket_manager.dart';
import '../services/storage/storage.dart';
import '../services/user/user_manager.dart';
import '../setup.dart';
import 'contracts/auth_contract.dart';
import 'contracts/message_manager_contract.dart';

class Core {
  static bool _isDependenciesLoaded = false;

  static get isDependenciesLoaded => _isDependenciesLoaded;

  static Future<void> makeCore() async {
    await _makeDependenciesInjector();
  }

  static Future<void> _makeDependenciesInjector() async {
    DI.makeDependency<AuthBloc>(() => AuthBloc());
    DI.makeDependency<ISetupAuthContract>(() => AuthContract());
    DI.makeDependency<ILogoutAuthContract>(() => AuthContract());

    DI.makeDependency<ProfileOverviewBloc>(() => ProfileOverviewBloc());

    DI.makeDependency<SocketManager>(() => SocketManager());
    DI.makeDependency<IChatMessageManagerContract>(() => MessageManagerContract());
    DI.makeDependency<ChatBloc>(() => ChatBloc());

    DI.makeDependency<Api>(() => Api());
    DI.makeDependency<Storage>(() => Storage());

    DI.makeDependency<UserManager>(() => UserManager(storage: DI.get<Storage>(), api: DI.get<Api>()));
  }

  static Future<void> initializeLazyServices() async {
    final userManager = DI.get<UserManager>();

    await userManager.initialize();
  }

  static Future<void> clearDependencies() async {
    return DI.clearDeps();
  }
}
