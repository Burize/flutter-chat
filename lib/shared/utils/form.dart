import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

abstract class StatelessWidgetWithFormController extends StatelessWidget {
  FormController controller;
}

class FormController {
  final GlobalKey<FormBuilderState> _formKey;
  Map<String, dynamic> get values {
    _formKey.currentState.save();
    return _formKey.currentState.value;
  }

  FormController(this._formKey);

  bool validate() {
    return _formKey.currentState.validate();
  }
}
