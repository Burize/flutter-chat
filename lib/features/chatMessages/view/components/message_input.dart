import 'package:flutter/material.dart';

typedef void TOnSubmit(String message);

class MessageInput extends StatefulWidget {
  final TOnSubmit onSubmit;

  MessageInput({@required this.onSubmit});
  @override
  createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      onEditingComplete: onSubmit,
      decoration: InputDecoration(
          hintText: "Enter new message",
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: onSubmit,
          )),
    );
  }

  onSubmit() {
    FocusScope.of(context).requestFocus(new FocusNode());
    widget.onSubmit(inputController.text);
    inputController.clear();
  }
}
