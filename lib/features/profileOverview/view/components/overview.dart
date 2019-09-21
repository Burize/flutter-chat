import 'package:flutter/material.dart';

import '../../../../shared/view/styles.dart';
import '../../../../shared/models/user.dart';
import '../../../../shared/view/components/empty.dart';

final textStyle = TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);

class Overview extends StatelessWidget {
  final User user;

  Overview({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              child: user.avatar == null
                  ? Text(
                      user.acronym,
                      style: TextStyle(fontSize: 32),
                    )
                  : Empty(),
              backgroundImage: user.avatar == null ? null : user.getAvatar(),
              radius: 48,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 12),
                    child: Column(children: [
                      Text(
                        user.firstName,
                        style: textStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.secondName,
                        style: textStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
