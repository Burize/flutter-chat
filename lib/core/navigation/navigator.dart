import 'package:flutter/material.dart' hide Route;

import 'routes.dart';

class RoutesNavigator {
  static Future<void> routeToReplacement(
    BuildContext context,
    Route route,
  ) async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: route.builder),
      (_) => false,
    );
  }

  static Future<void> routeToChild(BuildContext context, Route route, {bool isCloseDrawer}) async {
    if (isCloseDrawer != null && isCloseDrawer) {
      pop(context);
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: route.builder),
    );
  }

  static Future<void> routeToChildWidget(BuildContext context, Widget widget, {bool isCloseDrawer}) async {
    if (isCloseDrawer != null && isCloseDrawer) {
      pop(context);
    }
    final r = MaterialPageRoute(builder: (_) => widget);
    Navigator.of(context).push(r);
  }

  static bool pop(BuildContext context) {
    return Navigator.pop(context);
  }
}
