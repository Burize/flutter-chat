import '../../core/navigation/routes.dart';
import 'view/chat.dart';

class ChatRoutes {
  final chatMessages = Route(
    builder: (_) => ChatMessagesView(),
  );
}
