import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  // final AuthBloc bloc;
  // ChatMessages({Key key, @required this.bloc}) : super(key: key);
  Messages({Key key}) : super(key: key);

  @override
  createState() => _MessageState();
}

class _MessageState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[Text('there will be messages')],
      ),
    );
  }
}
