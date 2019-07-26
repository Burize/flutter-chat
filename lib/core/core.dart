import 'package:flutter_chat/core/contracts/message_manager_contract.dart';
import 'package:flutter_chat/features/chatMessages/bloc/bloc.dart';
import 'package:flutter_chat/features/chatMessages/bloc/externals.dart';
import 'package:flutter_chat/services/socket/socket_manager.dart';
import 'package:flutter_chat/services/storage/storage.dart';
import 'package:flutter_chat/services/user/user_manager.dart';

import '../features/auth/bloc/bloc.dart';

import '../services/api/api.dart';

import '../setup.dart';
import './dependency.dart';
import 'contracts/auth_contract.dart';

class Core {
  static bool _isDependenciesLoaded = false;

  static get isDependenciesLoaded => _isDependenciesLoaded;

  static Future<void> makeCore() async {
    await _makeDependenciesInjector();
  }

  static Future<void> _makeDependenciesInjector() async {
    DI.makeDependency<AuthBloc>(() => AuthBloc());
    DI.makeDependency<ISetupAuthContract>(() => AuthContract());

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
}
