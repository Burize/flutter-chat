import 'package:flutter/material.dart';
import 'package:flutter_chat/shared/view/styles.dart';

import '../../services/user/user_manager.dart';
import '../../shared/view/components/user_profile.dart';
import '../service_locator.dart';
import 'navigator.dart';
import 'routes.dart';

enum EDrawerRoutes {
  chat,
  profile,
}

Drawer makeMainDrawer(BuildContext context, EDrawerRoutes activeRoot) {
  final userManager = SL.get<UserManager>();
  final userProfile = UserProfile(
    user: userManager.user,
  );

  return Drawer(
      child: Column(
    children: [
      Container(
        color: primaryColor,
        padding: EdgeInsets.only(top: 16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: userProfile,
        ),
      ),
      Expanded(
        child: ListTileTheme(
          selectedColor: Colors.blueAccent,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Chat'),
                selected: activeRoot == EDrawerRoutes.chat,
                onTap: () => RoutesNavigator.routeToReplacement(context, Routes.chat.chatMessages),
              ),
              ListTile(
                title: Text('Profile'),
                selected: activeRoot == EDrawerRoutes.profile,
                onTap: () => RoutesNavigator.routeToChild(context, Routes.profile.overview, isCloseDrawer: true),
              ),
            ],
          ),
        ),
      ),
    ],
  ));
}
