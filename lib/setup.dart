import 'package:flutter/material.dart';

import './core/core.dart';
import './core/dependency.dart';
import 'core/navigation/navigator.dart';
import 'core/navigation/routes.dart';
import 'services/user/user_manager.dart';

abstract class ISetupAuthContract {
  Future<bool> checkAuth();
}

class Setup extends StatefulWidget {
  @override
  createState() => SetupState();
}

class SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Загрузка приложения...'),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Core.makeCore().then((_) => _coreInitialized(context));
  }

  _coreInitialized(BuildContext context) {
    _checkUserAuth();
  }

  void _checkUserAuth() async {
    final externals = Externals();
    final isAuthenticated = await externals.checkAuth();

    if (isAuthenticated) {
      await Core.initializeLazyServices();
      RoutesNavigator.routeToReplacement(context, Routes.chat.chatMessages);
      _tryUpdateUser();
    } else {
      RoutesNavigator.routeToReplacement(context, Routes.auth.authenticate);
    }
  }

  void _tryUpdateUser() async {
    try {
      final userManager = DI.get<UserManager>();
      await userManager.updateUser();
    } catch (e) {
      // when offline there is network error, but app is not need to react to it
      print(e.toString());
    }
  }
}

class Externals {
  ISetupAuthContract _auth;

  Externals() {
    _auth = DI.get<ISetupAuthContract>();
  }

  Future<bool> checkAuth() async {
    return _auth.checkAuth();
  }
}
