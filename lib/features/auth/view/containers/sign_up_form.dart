import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../shared/utils/string.dart';
import '../../../../shared/view/styles.dart';
import '../../bloc/bloc.dart';
import '../../bloc/namespace.dart';

class SignUpForm extends StatefulWidget {
  final AuthBloc bloc;
  final TOnRegistrate onRegistrate;
  SignUpForm({Key key, @required this.bloc, this.onRegistrate}) : super(key: key);
  @override
  createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    widget.bloc.events.listen(handleBlocEvent);
    super.initState();
  }

  void handleBlocEvent(IAuthEvents event) {
    if (event is RegistrateFail) {
      _showError(event.payload);
    }
  }

  void _onSubmit() async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      final values = _formKey.currentState.value;
      final isSuccess = await widget.bloc.registrate(
        values['firstName'],
        values['secondName'],
        values['phone'],
        values['password'],
      );
      if (isSuccess) {
        widget.onRegistrate(context);
      }
    }
  }

  void _showError(String error) {
    Flushbar(
      title: "Error",
      message: error,
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: 4),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(20),
      child: FormBuilder(
          key: _formKey,
          child: ListView(children: [
            FormBuilderTextField(
              attribute: 'firstName',
              decoration: InputDecoration(hintText: 'Henry', labelText: 'First name'),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.maxLength(14),
                FormBuilderValidators.pattern(nonNumericPattern, errorText: 'must not contains numbers'),
              ],
            ),
            FormBuilderTextField(
              attribute: 'secondName',
              decoration: InputDecoration(hintText: 'Dorsett', labelText: 'Second name'),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.maxLength(14),
                FormBuilderValidators.pattern(nonNumericPattern, errorText: 'must not contains numbers'),
              ],
            ),
            FormBuilderTextField(
              attribute: 'phone',
              decoration: InputDecoration(hintText: 'Phone number', labelText: formPlaceholder),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.pattern(phonePattern, errorText: 'wrong phone format'),
              ],
            ),
            FormBuilderTextField(
              attribute: 'password',
              obscureText: true,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(4),
                FormBuilderValidators.maxLength(12)
              ],
              decoration: InputDecoration(hintText: 'Password', labelText: 'Enter your password'),
            ),
            Container(
              width: screenSize.width,
              child: RaisedButton(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _onSubmit,
                color: primaryColor,
              ),
              margin: EdgeInsets.only(top: 20.0),
            ),
          ])),
    );
  }
}
