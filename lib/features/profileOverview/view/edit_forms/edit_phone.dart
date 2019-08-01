import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../shared/utils/string.dart';

class EditPhoneForm extends StatelessWidget {
  final String phone;
  final GlobalKey<FormBuilderState> formKey;

  EditPhoneForm({Key key, @required this.formKey, @required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: FormBuilder(
          key: formKey,
          child: ListView(children: [
            FormBuilderTextField(
              initialValue: phone,
              attribute: 'phone',
              decoration: new InputDecoration(hintText: 'Phone number', labelText: '+7 913 813 33 33'),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.pattern(phonePattern, errorText: 'wrong phone format'),
              ],
            ),
          ])),
    );
  }
}
