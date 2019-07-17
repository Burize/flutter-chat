import 'package:flutter_chat/core/contracts/message_manager_contract.dart';
import 'package:flutter_chat/features/chatMessages/bloc/bloc.dart';
import 'package:flutter_chat/features/chatMessages/bloc/externals.dart';
import 'package:flutter_chat/services/socket/socket_manager.dart';

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
    DI.makeDependency<SocketManager>(() => SocketManager());

    DI.makeDependency<IChatMessageManagerContract>(() => MessageManagerContract());

    DI.makeDependency<AuthBloc>(() => AuthBloc());
    DI.makeDependency<ChatBloc>(() => ChatBloc());
  }
}
