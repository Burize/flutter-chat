import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../shared/utils/form.dart';
import '../../../../shared/utils/string.dart';

class EditNameForm extends StatelessWidgetWithFormController {
  final String _firstName;
  final String _secondName;
  final GlobalKey<FormBuilderState> _formKey;
  FormController controller;

  EditNameForm({String firstName, String secondName})
      : _firstName = firstName,
        _secondName = secondName,
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
              initialValue: _firstName,
              attribute: 'firstName',
              decoration: new InputDecoration(hintText: 'Henry', labelText: 'First name'),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.maxLength(14),
                FormBuilderValidators.pattern(nonNumericPattern, errorText: 'must not contains numbers'),
              ],
            ),
            FormBuilderTextField(
              initialValue: _secondName,
              attribute: 'secondName',
              decoration: new InputDecoration(hintText: 'Dorsett', labelText: 'Second name'),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.maxLength(14),
                FormBuilderValidators.pattern(nonNumericPattern, errorText: 'must not contains numbers'),
              ],
            ),
          ])),
    );
  }
}
