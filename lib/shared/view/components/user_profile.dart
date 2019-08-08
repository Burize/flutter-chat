import 'package:flutter/material.dart';
import 'package:flutter_chat/shared/view/components/empty.dart';

import '../../models/user.dart';

class UserProfile extends StatelessWidget {
  final User user;

  UserProfile({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            child: user.avatar == null
                ? Text(
                    user.acronym,
                    style: TextStyle(fontSize: 24),
                  )
                : Empty(),
            backgroundImage: user.avatar == null ? null : user.getAvatar(),
            radius: 40,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    user.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 12),
                  child: Text(user.phone),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
