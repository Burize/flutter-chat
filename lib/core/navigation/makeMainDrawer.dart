import 'package:flutter/material.dart';

import '../../services/user/user_manager.dart';
import '../../shared/view/components/user_profile.dart';
import '../dependency.dart';
import 'navigator.dart';
import 'routes.dart';

Drawer makeMainDrawer(BuildContext context, int activeItemIndex) {
  final userManager = DI.get<UserManager>();
  final userProfile = UserProfile(
    user: userManager.user,
  );

  return Drawer(
      child: Column(
    children: [
      Container(
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
            padding: EdgeInsets.all(0),
            children: <Widget>[
              ListTile(
                title: Text('Chat'),
                selected: activeItemIndex == 0,
                onTap: () => RoutesNavigator.routeToReplacement(context, Routes.chat.chatMessages),
              ),
              ListTile(
                title: Text('Profile'),
                selected: activeItemIndex == 1,
                onTap: () => RoutesNavigator.routeToChild(context, Routes.profile.overview, isCloseDrawer: true),
              ),
            ],
          ),
        ),
      ),
    ],
  ));
}
