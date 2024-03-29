import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/shared/utils/form.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/service_locator.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../services/user/user_manager.dart';
import '../../../../shared/models/user.dart';
import '../../bloc/bloc.dart';
import '../../bloc/namespace.dart';
import '../../bloc/state.dart';
import '../components/account_fields.dart';
import '../components/edit_field.dart';
import '../components/overview.dart';
import '../edit_forms/edit_name.dart';
import '../edit_forms/edit_phone.dart';

class AccountView extends StatefulWidget {
  final ProfileOverviewBloc bloc;
  AccountView({Key key, @required this.bloc}) : super(key: key);
  @override
  createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    final userManager = SL.get<UserManager>();
    final user = userManager.user;
    return BlocBuilder<IProfileEvents, ProfileState>(
        bloc: widget.bloc,
        builder: (
          BuildContext context,
          ProfileState state,
        ) {
          final isDisableEditing =
              state.changingName.isRequesting || state.changingPhone.isRequesting || state.changingAvatar.isRequesting;
          return Container(
            child: Column(
              children: [
                Overview(user: user),
                AccountFields(
                  user: user,
                  onEdit: onEditAccount,
                  isLoading: isDisableEditing,
                  additionalFields: [
                    ListTile(
                      title: Text('User avatar'),
                      subtitle: Text('Press to change avatar'),
                      onTap: () {
                        changeAvatar(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  onEditAccount(EAccountEditedFiled field) {
    final userManager = SL.get<UserManager>();
    final user = userManager.user;

    final form = formByType[field];
    final title = titleByType[field];

    final handlerByType = {
      EAccountEditedFiled.phone: onEditPhone,
      EAccountEditedFiled.name: onEditName,
    };

    final formWidget = form(user);
    RoutesNavigator.routeToChildWidget(
        context,
        EditField(
          title: title,
          editForm: formWidget,
          onSave: () {
            if (formWidget.controller.validate()) {
              final values = formWidget.controller.values;
              handlerByType[field](values);
              RoutesNavigator.pop(context);
            }
          },
        ));
  }

  onEditPhone(Map<String, dynamic> values) {
    final phone = values['phone'];
    widget.bloc.changePhone(phone);
  }

  onEditName(Map<String, dynamic> values) {
    final firstName = values['firstName'];
    final secondName = values['secondName'];
    widget.bloc.changeName(firstName, secondName);
  }

  changeAvatar(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  title: Text('From camera'),
                  onTap: () {
                    getImage(context, ImageSource.camera);
                  },
                ),
                ListTile(
                  title: Text('From gallery'),
                  onTap: () {
                    getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future getImage(BuildContext context, ImageSource source) async {
    RoutesNavigator.pop(context);
    File image = await ImagePicker.pickImage(source: source);

    List<int> imageBytes = image.readAsBytesSync();
    String base64Payload = base64.encode(imageBytes);

    final imageExtension = image.path.split('.').last;
    final base64Image = 'data:image/$imageExtension;base64,$base64Payload';
    widget.bloc.changeAvatar(base64Image);
  }
}

final Map<EAccountEditedFiled, StatelessWidgetWithFormController Function(User)> formByType = {
  EAccountEditedFiled.phone: (User user) => EditPhoneForm(phone: user.phone),
  EAccountEditedFiled.name: (User user) => EditNameForm(firstName: user.firstName, secondName: user.secondName),
};

final titleByType = {
  EAccountEditedFiled.phone: 'Телефон',
  EAccountEditedFiled.name: 'Имя пользователя',
};
