import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/auth/bloc/bloc.dart';
import 'package:flutter_chat/features/auth/bloc/namespace.dart';
import 'package:flutter_chat/features/auth/bloc/state.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class SignUpForm extends StatefulWidget {
  final AuthBloc bloc;
  final TOnAuthenticate onAuthenticate;
  SignUpForm({Key key, @required this.bloc, this.onAuthenticate}) : super(key: key);
  @override
  createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    super.initState();
    widget.bloc.onAuthenticate = onAuthenticate;
  }

  final GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();

  void _onSubmit() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      final values = _formKey.currentState.value;
      widget.bloc.registrate(values['firstName'], values['secondName'], values['phone'], values['password']);
    }
  }

  void onAuthenticate() {
    widget.onAuthenticate(context);
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
              attribute: 'firstName',
              decoration: new InputDecoration(hintText: 'Henry', labelText: 'First name'),
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            FormBuilderTextField(
              attribute: 'secondName',
              decoration: new InputDecoration(hintText: 'Dorsett', labelText: 'Second name'),
              validators: [
                FormBuilderValidators.required(),
              ],
            ),
            FormBuilderTextField(
              attribute: 'phone',
              decoration: new InputDecoration(hintText: 'Phone number', labelText: '+7 913 813 33 33'),
              validators: [
                FormBuilderValidators.required(),
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
              decoration: new InputDecoration(hintText: 'Password', labelText: 'Enter your password'),
            ),
            Container(
              width: screenSize.width,
              child: new RaisedButton(
                child: new Text(
                  'Login',
                  style: new TextStyle(color: Colors.white),
                ),
                onPressed: _onSubmit,
                color: Colors.blue,
              ),
              margin: new EdgeInsets.only(top: 20.0),
            ),
            BlocBuilder<IAuthEvents, AuthState>(
                bloc: widget.bloc,
                builder: (
                  BuildContext context,
                  AuthState state,
                ) {
                  return Text(state.authenticating.isRequesting.toString());
                }),
          ])),
    );
  }
}
