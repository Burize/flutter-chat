import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/dependency.dart';
import 'package:flutter_chat/features/chatMessages/bloc/bloc.dart';
import 'package:flutter_chat/features/chatMessages/bloc/namespace.dart';
import 'package:flutter_chat/features/chatMessages/bloc/state.dart';
import 'package:flutter_chat/features/chatMessages/view/components/chat_message.dart';
import 'package:flutter_chat/features/chatMessages/view/components/message_input.dart';
import 'package:flutter_chat/services/user/user_manager.dart';

class MessagesList extends StatefulWidget {
  final ChatBloc bloc;
  MessagesList({Key key, @required this.bloc}) : super(key: key);

  @override
  createState() => _MessageListState();
}

class _MessageListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    final userManager = DI.get<UserManager>();
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Expanded(
            child: BlocBuilder<IChatEvents, ChatState>(
              bloc: widget.bloc,
              builder: (
                BuildContext context,
                ChatState state,
              ) {
                return Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final messageUser = state.members.firstWhere(
                        (user) => user.id == message.userId,
                        orElse: () => unknownMember,
                      );
                      return ChatMessage(
                        message: message.body,
                        userName: messageUser.name,
                        isOwnMessage: message.userId == userManager.user.id,
                        createdAt: message.createdAt,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          MessageInput(onSubmit: sendMessage),
        ]));
  }

  sendMessage(String message) {
    widget.bloc.sendMessage(message);
  }
}
