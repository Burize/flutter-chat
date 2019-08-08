import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../shared/utils/string.dart';
import '../../../../shared/view/components/empty.dart';
import '../../../../shared/view/styles.dart';
import '../../bloc/bloc.dart';
import '../../bloc/namespace.dart';
import '../../bloc/state.dart';

class SignInForm extends StatefulWidget {
  final AuthBloc bloc;
  final TOnAuthenticate onAuthenticate;
  SignInForm({Key key, @required this.bloc, @required this.onAuthenticate}) : super(key: key);

  @override
  createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    widget.bloc.events.listen(handleBlocEvent);
    super.initState();
  }

  void handleBlocEvent(IAuthEvents event) {
    if (event is AuthenticateFail) {
      _showError(event.payload);
    }
  }

  void _onSubmit() async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      final values = _formKey.currentState.value;
      final isSuccess = await widget.bloc.authenticate(values['phone'], values['password']);
      if (isSuccess) {
        widget.onAuthenticate(context);
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
          // autovalidate: true,
          child: ListView(children: [
            FormBuilderTextField(
              attribute: 'phone',
              decoration: InputDecoration(hintText: formPlaceholder, labelText: 'Phone number'),
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
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _onSubmit,
                color: primaryColor,
              ),
              margin: EdgeInsets.only(top: 20.0),
            ),
            BlocBuilder<IAuthEvents, AuthState>(
                bloc: widget.bloc,
                builder: (
                  BuildContext context,
                  AuthState state,
                ) {
                  return state.registrating.error != null ? Text(state.registrating.error) : Empty();
                }),
          ])),
    );
  }
}
