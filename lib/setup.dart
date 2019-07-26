import 'package:flutter/material.dart';

import './core/core.dart';
import './core/dependency.dart';
import 'core/navigator.dart';
import 'core/routes.dart';

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
      RoutesNavigator.routeToReplacement(context, ERoutes.chat);
    } else {
      RoutesNavigator.routeToReplacement(context, ERoutes.auth);
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
