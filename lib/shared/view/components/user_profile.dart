import 'package:flutter/material.dart';

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
          user.avatar != null
              ? CircleAvatar(
                  backgroundImage: user.getAvatar(),
                  radius: 40,
                )
              : CircleAvatar(
                  child: Text(
                    'DK',
                    style: TextStyle(fontSize: 24),
                  ),
                  radius: 40,
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, left: 12),
                child: Text(user.name),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, left: 12),
                child: Text(user.phone),
              ),
            ],
          )
        ],
      ),
    );
  }
}
