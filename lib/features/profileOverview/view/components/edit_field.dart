import 'package:flutter/material.dart';

typedef TOnSave();

class EditField extends StatelessWidget {
  final String title;
  final String description;
  final Widget editForm;
  final TOnSave onSave;

  EditField({this.title, this.description, this.editForm, this.onSave});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: onSave,
          ),
        ],
      ),
      body: Container(child: editForm),
    );
  }
}
