import './service_locator.dart';
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
    SL.makeDependency<AuthBloc>(() => AuthBloc());
    SL.makeDependency<ISetupAuthContract>(() => AuthContract());
    SL.makeDependency<ILogoutAuthContract>(() => AuthContract());

    SL.makeDependency<ProfileOverviewBloc>(() => ProfileOverviewBloc());

    SL.makeDependency<SocketManager>(() => SocketManager());
    SL.makeDependency<IChatMessageManagerContract>(() => MessageManagerContract());
    SL.makeDependency<ChatBloc>(() => ChatBloc());

    SL.makeDependency<Api>(() => Api());
    SL.makeDependency<Storage>(() => Storage());

    SL.makeDependency<UserManager>(() => UserManager(storage: SL.get<Storage>(), api: SL.get<Api>()));
  }

  static Future<void> initializeLazyServices() async {
    final userManager = SL.get<UserManager>();
    final socketmanager = SL.get<SocketManager>();

    await userManager.initialize();
    await socketmanager.initialize();
  }

  static Future<void> clearDependencies() async {
    return SL.clearDeps();
  }
}
