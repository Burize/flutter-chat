import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/navigator.dart';
import 'package:flutter_chat/core/routes.dart';
import 'package:flutter_chat/features/auth/bloc/bloc.dart';
import 'package:flutter_chat/features/auth/bloc/namespace.dart';
import 'package:flutter_chat/features/auth/bloc/state.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignInForm extends StatefulWidget {
  final AuthBloc bloc;
  SignInForm({Key key, @required this.bloc}) : super(key: key);

  @override
  createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<SignInForm> {
  @override
  void initState() {
    super.initState();
    widget.bloc.onAuthenticate = onAuthenticate;
  }

  final GlobalKey<FormBuilderState> _formKey =
      new GlobalKey<FormBuilderState>();

  void _onSubmit() {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      print('Email: ${_formKey.currentState.value}');
      widget.bloc.authenticate();
    }
  }

  void onAuthenticate(bool isConfirmed) {
    RoutesNavigator.routeToReplacement(context, ERoutes.chat);
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
              attribute: 'email',
              decoration: new InputDecoration(
                  hintText: 'you@example.com', labelText: 'E-mail Address'),
              validators: [
                FormBuilderValidators.required(),
                // FormBuilderValidators.email()
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
              decoration: new InputDecoration(
                  hintText: 'Password', labelText: 'Enter your password'),
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
