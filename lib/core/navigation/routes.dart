import 'package:flutter/material.dart';

import '../../modules/auth/routes.dart';
import '../../modules/chat/routes.dart';
import '../../modules/profile/routes.dart';
import '../../setup.dart';

class Routes {
  static final root = Route(builder: (_) => Setup());
  static final auth = AuthRoutes();
  static final chat = ChatRoutes();
  static final profile = ProfileRoutes();
}

class Route<T> {
  WidgetBuilder builder;
  Route({WidgetBuilder this.builder});
}

typedef TPassArgumentToRoute<T> = Route Function(T);
