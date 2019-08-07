import 'package:flutter/material.dart';

import '../../../core/navigation/makeMainDrawer.dart';
import '../../../features/chatMessages/chatMessages.dart';

class ChatMessagesView extends StatelessWidget {
  final ChatMessages _chatMessages = ChatMessages();
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      drawer: makeMainDrawer(context, EDrawerRoutes.chat),
      body: _chatMessages.chatView(),
    );
  }
}
