import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../shared/utils/string.dart';

class EditNameForm extends StatelessWidget {
  final String firstname;
  final String secondName;
  final GlobalKey<FormBuilderState> formKey;

  EditNameForm({Key key, @required this.formKey, @required this.firstname, @required this.secondName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: FormBuilder(
          key: formKey,
          child: ListView(children: [
            FormBuilderTextField(
              initialValue: firstname,
              attribute: 'firstName',
              decoration: new InputDecoration(hintText: 'Henry', labelText: 'First name'),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.maxLength(14),
                FormBuilderValidators.pattern(nonNumericPattern, errorText: 'must not contains numbers'),
              ],
            ),
            FormBuilderTextField(
              initialValue: secondName,
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
