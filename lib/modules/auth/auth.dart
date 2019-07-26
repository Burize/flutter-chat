import 'package:flutter/material.dart';
import 'package:flutter_chat/core/core.dart';
import 'package:flutter_chat/core/navigator.dart';
import 'package:flutter_chat/core/routes.dart';
import 'package:flutter_chat/features/auth/auth.dart';

class AuthModule extends StatelessWidget {
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
            _auth.signInForm(onAuthenticate),
            _auth.signUpForm(onAuthenticate),
          ],
        ),
      ),
    );
  }

  void onAuthenticate(BuildContext context) async {
    await Core.initializeLazyServices();
    RoutesNavigator.routeToReplacement(context, ERoutes.chat);
  }
}
