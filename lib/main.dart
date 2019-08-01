import 'package:flutter/material.dart';

import 'setup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      home: Setup(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(52, 45, 62, 1),
      ),
    );
  }
}
