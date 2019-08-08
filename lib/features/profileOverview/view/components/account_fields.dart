import 'package:flutter/material.dart';

import '../../../../shared/models/user.dart';
import '../../../../shared/view/components/empty.dart';

enum EAccountEditedFiled {
  phone,
  name,
}

typedef TOnEdit(EAccountEditedFiled field);

class AccountFields extends StatelessWidget {
  final User user;
  final TOnEdit onEdit;
  final bool isLoading;
  final List<ListTile> additionalFields;

  AccountFields({@required this.user, @required this.onEdit, this.isLoading = false, this.additionalFields});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Stack(
          children: [
            ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    title: Text(user.phone),
                    subtitle: Text('Номер телефона'),
                    onTap: () {
                      onEdit(EAccountEditedFiled.phone);
                    },
                  ),
                  ListTile(
                    title: Text(user.name, overflow: TextOverflow.ellipsis),
                    subtitle: Text('Имя пользователя'),
                    onTap: () {
                      if (!isLoading) {
                        onEdit(EAccountEditedFiled.name);
                      }
                    },
                  ),
                ]..addAll(additionalFields ?? []),
              ).toList(),
            ),
            isLoading
                ? Positioned.fill(
                    child: Container(color: Color.fromRGBO(0, 0, 0, 0.2)),
                  )
                : Empty(),
          ],
        ),
      ),
    );
  }
}
