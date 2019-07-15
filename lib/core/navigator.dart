import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart' as FlutterWidgets;

import './routes.dart';

class RoutesNavigator {
  static Future<void> routeToReplacement(
    FlutterWidgets.BuildContext context,
    ERoutes route,
  ) async {
    Route r = MaterialPageRoute(
        builder: (context) => Routes.getRouteWidget(context, route));
    FlutterWidgets.Navigator.of(context).pushAndRemoveUntil(r, (_) => false);
  }

  static Future<void> routeToChildNamed(
    FlutterWidgets.BuildContext context,
    ERoutes route,
  ) async {
    FlutterWidgets.Navigator.of(context)
        .pushNamed(Routes.getRouteString(route));
  }

  static Future<void> routeToChildWidget(
    FlutterWidgets.BuildContext context,
    Widget widget,
  ) async {
    FlutterWidgets.Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static bool pop(FlutterWidgets.BuildContext context) {
    return Navigator.pop(context);
  }

  static Future<void> routeToReplacementWithParams(
    FlutterWidgets.BuildContext context,
    ERoutes routeType,
    dynamic arguments,
  ) {
    Route route = MaterialPageRoute(
      builder: (context) => Routes.getRouteWidget(context, routeType),
      settings: RouteSettings(arguments: arguments),
    );
    return FlutterWidgets.Navigator.of(context)
        .pushAndRemoveUntil(route, (_) => false);
  }
}
