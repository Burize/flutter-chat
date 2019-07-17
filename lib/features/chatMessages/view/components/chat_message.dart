import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  ChatMessage({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(message),
    );
  }
}
