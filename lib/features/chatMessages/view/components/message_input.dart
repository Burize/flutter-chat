import 'package:flutter/material.dart';
import 'package:flutter_chat/shared/view/components/empty.dart';

typedef void TOnSubmit(String message);

class MessageInput extends StatefulWidget {
  final TOnSubmit onSubmit;
  final bool isDisabled;

  MessageInput({@required this.onSubmit, this.isDisabled = false});
  @override
  createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final inputController = TextEditingController();
  bool _isEmpty = true;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.isDisabled || _isEmpty;
    return TextField(
      controller: inputController,
      onEditingComplete: _onSubmit,
      onChanged: _onChangeMessage,
      minLines: 1,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: "Enter new message",
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: _onSubmit,
            color: isDisabled ? Colors.grey : Colors.black,
          )),
    );
  }

  _onChangeMessage(String message) {
    if (_isEmpty && message.isNotEmpty) {
      setState(() {
        _isEmpty = false;
      });
    }

    if (!_isEmpty && message.isEmpty) {
      setState(() {
        _isEmpty = true;
      });
    }
  }

  _onSubmit() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (widget.isDisabled || inputController.text.isEmpty) {
      return;
    }
    widget.onSubmit(inputController.text);
    // this throw exception due flutter at that moment, - it doesn't break anything
    // with new sdk it will be fixed
    inputController.clear();
  }
}
