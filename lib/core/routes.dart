import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat/modules/chat/chat.dart';

import '../modules/auth/auth.dart';

import '../setup.dart';

import './navigator.dart';

enum ERoutes {
  root,
  auth,
  chat,
}

typedef Widget TWidgetConstructor(BuildContext context);

class Routes {
  static final Map<String, TWidgetConstructor> routes = {
    getRouteString(ERoutes.root): (context) => Setup(),
    getRouteString(ERoutes.auth): (context) => AuthModule(),
    getRouteString(ERoutes.chat): (context) => ChatModule(),
  };

  static String getRouteString(ERoutes route) {
    Map<ERoutes, String> map = {
      ERoutes.root: '/',
      ERoutes.auth: '/auth',
      ERoutes.chat: '/chat',
    };
    return map[route];
  }

  static Widget getRouteWidget(BuildContext context, ERoutes route) {
    return routes[getRouteString(route)](context);
  }
}

Drawer makeMainDrawer(BuildContext context, int activeItemIndex) {
  return Drawer(
    child: ListTileTheme(
      selectedColor: Colors.blueAccent,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Chat'),
            selected: activeItemIndex == 0,
            onTap: () =>
                RoutesNavigator.routeToReplacement(context, ERoutes.chat),
          ),
        ],
      ),
    ),
  );
}
