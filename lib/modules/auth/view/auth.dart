import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/navigation/routes.dart';
import '../../../features/auth/auth.dart';

class AuthenticateView extends StatelessWidget {
  final Auth _auth = Auth();
  @override
  build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Sign in'),
              Tab(text: 'Rigistration'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _auth.signInForm(initializeDeps),
            _auth.signUpForm(initializeDeps),
          ],
        ),
      ),
    );
  }

  void initializeDeps(BuildContext context) async {
    await Core.initializeLazyServices();
    RoutesNavigator.routeToReplacement(context, Routes.chat.chatMessages);
  }
}
