import 'package:flutter/material.dart';

import '../../../../shared/models/user.dart';

final textStyle = TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);

class Overview extends StatelessWidget {
  final User user;

  Overview({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(52, 45, 62, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            user.avatar != null
                ? CircleAvatar(
                    backgroundImage: user.getAvatar(),
                    radius: 48,
                  )
                : CircleAvatar(
                    child: Text(
                      'DK',
                      style: TextStyle(fontSize: 32),
                    ),
                    radius: 48,
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 12),
                  child: Column(children: [
                    Text(user.firstName, style: textStyle),
                    Text(user.secondName, style: textStyle),
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
