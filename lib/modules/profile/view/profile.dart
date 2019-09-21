import 'package:flutter/material.dart';

import '../../../core/service_locator.dart';
import '../../../core/navigation/navigator.dart';
import '../../../core/navigation/routes.dart';
import '../../../features/profileOverview/profileOverview.dart';

abstract class ILogoutAuthContract {
  Future<void> logout();
}

class ProfileView extends StatelessWidget {
  final ProfileOverview _profileOverview = ProfileOverview();
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          InkWell(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Logout'),
              ),
            ),
            onTap: () {
              onLogout(context);
            },
          ),
        ],
      ),
      body: _profileOverview.accountView(),
    );
  }

  onLogout(BuildContext context) async {
    final externals = Externals();
    await externals.logout();
    RoutesNavigator.routeToReplacement(context, Routes.root);
  }
}

class Externals {
  ILogoutAuthContract _auth;

  Externals() {
    _auth = SL.get<ILogoutAuthContract>();
  }

  Future<void> logout() async {
    return _auth.logout();
  }
}
