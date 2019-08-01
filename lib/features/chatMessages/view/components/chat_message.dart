import 'package:flutter/material.dart';

import '../../../../shared/view/components/empty.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String userName;
  final String userAcronym;
  final int createdAt;
  final ImageProvider avatar;
  final bool isOwnMessage;

  ChatMessage({this.message, this.isOwnMessage, this.userName, this.userAcronym, this.createdAt, this.avatar});

  @override
  Widget build(BuildContext context) {
    final createdAtDate = DateTime.fromMillisecondsSinceEpoch(createdAt);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isOwnMessage
              ? CircleAvatar(
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                )
              : getMemberAvatar(),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isOwnMessage ? Empty() : Text(userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Text(message),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('${createdAtDate.hour}:${createdAtDate.minute}'),
                    ],
                  )
                ],
              ),
            ),
          )
        ]);
  }

  Widget getMemberAvatar() {
    return avatar != null ? CircleAvatar(backgroundImage: avatar) : CircleAvatar(child: Text(userAcronym));
  }
}
