import 'package:flutter/material.dart';
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
            _auth.signInForm(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
