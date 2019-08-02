import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator.dart';
import '../../../../services/user/user_manager.dart';
import '../../bloc/bloc.dart';
import '../../bloc/namespace.dart';
import '../../bloc/state.dart';
import '../components/chat_message.dart';
import '../components/message_input.dart';

class MessagesList extends StatefulWidget {
  final ChatBloc bloc;
  MessagesList({Key key, @required this.bloc}) : super(key: key);

  @override
  createState() => _MessageListState();
}

class _MessageListState extends State<MessagesList> {
  @override
  void initState() {
    widget.bloc.events.listen(handleBlocEvent);
    super.initState();
  }

  void handleBlocEvent(IChatEvent event) {
    if (event is LoadMembersFail) {
      _showError(event.payload, title: 'There is errror when load chat members');
    }
  }

  void _showError(String error, {String title}) {
    Flushbar(
      title: title ?? "Error",
      message: error,
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: 4),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    final userManager = SL.get<UserManager>();
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Expanded(
            child: BlocBuilder<IChatEvent, ChatState>(
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
                        userAcronym: messageUser.acronym,
                        avatar: messageUser.avatar != null ? messageUser.getAvatar() : null,
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
