import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/chatMessages/bloc/bloc.dart';
import 'package:flutter_chat/features/chatMessages/bloc/namespace.dart';
import 'package:flutter_chat/features/chatMessages/bloc/state.dart';
import 'package:flutter_chat/features/chatMessages/view/components/chat_message.dart';

class MessagesList extends StatefulWidget {
  final ChatBloc bloc;
  MessagesList({Key key, @required this.bloc}) : super(key: key);

  @override
  createState() => _MessageListState();
}

class _MessageListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: BlocBuilder<IChatEvents, ChatState>(
        bloc: widget.bloc,
        builder: (
          BuildContext context,
          ChatState state,
        ) {
          return Container(
            child: ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                return ChatMessage(message: state.messages[index]?.body);
              },
            ),
          );
        },
      ),
    );
  }
}
