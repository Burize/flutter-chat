import 'package:flutter/material.dart';
import 'package:flutter_chat/core/routes.dart';
import 'package:flutter_chat/features/chatMessages/chatMessages.dart';

class ChatModule extends StatelessWidget {
  final ChatMessages _chatMessages = ChatMessages();
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      drawer: makeMainDrawer(context, 0),
      body: _chatMessages.chatView(),
    );
  }
}
