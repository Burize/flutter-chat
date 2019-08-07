import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../shared/utils/form.dart';
import '../../../../shared/utils/string.dart';

class EditPhoneForm extends StatelessWidgetWithFormController {
  final String _phone;
  final GlobalKey<FormBuilderState> _formKey;
  FormController controller;

  EditPhoneForm({String phone})
      : _phone = phone,
        _formKey = GlobalKey<FormBuilderState>() {
    controller = FormController(_formKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: FormBuilder(
          key: _formKey,
          child: ListView(children: [
            FormBuilderTextField(
              initialValue: _phone,
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
