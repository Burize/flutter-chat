import 'package:flutter/material.dart';

import 'setup.dart';
import 'shared/view/styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      home: Setup(),
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
    );
  }
}
