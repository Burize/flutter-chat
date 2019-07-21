import 'package:flutter/material.dart';
import 'package:flutter_chat/shared/view/components/empty.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isOwnMessage;
  ChatMessage({@required this.message, this.isOwnMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        !isOwnMessage ? CircleAvatar(child: Text('DK')) : Empty(),
        isOwnMessage
            ? CircleAvatar(
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              )
            : Empty(),
        Flexible(
          child: Card(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(message),
          )),
        ),
      ],
    );
  }
}
