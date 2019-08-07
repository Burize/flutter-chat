import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/services/socket/namespace.dart';
import 'package:flutter_chat/shared/view/components/spinner.dart';

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
      _showError(event.payload, title: 'There is error when load chat members');
    }
    if (event is ChangeConnectionStatus && event.payload == EConnectionStatus.error) {
      _showError('Trying reconect ...', title: 'There are some errors at network connection');
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
    return BlocBuilder<IChatEvent, ChatState>(
        bloc: widget.bloc,
        builder: (
          BuildContext context,
          ChatState state,
        ) {
          return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: state.connectionStatus != EConnectionStatus.pending
                        ? ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            reverse: true,
                            children: state.messages.map((message) {
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
                            }).toList(),
                          )
                        : Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Spinner(diameter: 24),
                            ],
                          ),
                  )),
                  MessageInput(
                    onSubmit: sendMessage,
                    isDisabled: state.connectionStatus != EConnectionStatus.connected,
                  ),
                ],
              ));
        });
  }

  sendMessage(String message) {
    widget.bloc.sendMessage(message);
  }
}
