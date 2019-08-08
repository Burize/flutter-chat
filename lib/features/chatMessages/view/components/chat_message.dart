import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isOwnMessage
              ? CircleAvatar(
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                )
              : _getMemberAvatar(),
          Flexible(
            child: Card(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              isOwnMessage
                                  ? Empty()
                                  : Text(userName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              Text(message),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Text(
                            _getCreatedDate(createdAt),
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ]);
  }

  String _getCreatedDate(int createdAt) {
    final createdAtDate = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final now = DateTime.now();

    final difference = now.difference(createdAtDate);

    if (difference.inDays > 30) {
      return DateFormat('hh:mm dd MM').format(createdAtDate);
    }

    if (difference.inDays > 7) {
      return DateFormat('hh:mm dd MMM').format(createdAtDate);
    }

    if (difference.inDays > 0) {
      return DateFormat('hh:mm EE').format(createdAtDate);
    }

    return DateFormat('hh:mm').format(createdAtDate);
  }

  Widget _getMemberAvatar() {
    return avatar != null
        ? CircleAvatar(backgroundColor: Colors.grey, foregroundColor: Colors.white, backgroundImage: avatar)
        : CircleAvatar(backgroundColor: Colors.grey, foregroundColor: Colors.white, child: Text(userAcronym));
  }
}
