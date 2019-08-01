import './externals.dart';
import './namespace.dart';
import './state.dart';
import './state_map_event.dart';
import '../../../core/dependency.dart';
import '../../../services/api/api.dart';
import '../../../services/socket/namespace.dart';
import '../../../services/user/user_manager.dart';
import '../../../shared/bloc/events.dart';
import '../../../shared/models/message.dart';

class ChatBloc extends IFeatureBloc<IChatEvent, ChatState, AuthMapEvents> {
  final ChatState _initialState = ChatState.initial();
  ChatState get initialState => _initialState;

  final AuthMapEvents _mapEvent = AuthMapEvents();
  AuthMapEvents get mapEvent => _mapEvent;

  IChatMessageManagerContract messageManager;

  ChatBloc() {
    messageManager = DI.get<IChatMessageManagerContract>();
    messageManager.subscribe(_onReceiveMessage);
  }

  Future<void> _onReceiveMessage(IMessageEvent event) async {
    if (event is AllMessagesEvent) {
      final memberIds = event.messages.map((message) => message.userId).toSet().toList();
      await loadMembers(memberIds);
      dispatch(NewMessages(event.messages));
    }

    if (event is NewMessageEvent) {
      await loadMembers([event.message.userId]);
      dispatch(NewMessage(event.message));
    }

    if (event is SendedMessageEvent) {
      dispatch(SendedMessage(event.message));
    }
  }

  Future<void> loadMembers(List<String> ids) async {
    try {
      dispatch(LoadMembers());
      final api = DI.get<Api>();
      final users = await api.chatMember.loadUsers(ids);
      dispatch(LoadMembersSuccess(users));
    } catch (error) {
      dispatch(LoadMembersFail(error));
    }
  }

  sendMessage(String messageBody) {
    final userManager = DI.get<UserManager>();
    final message = IChatMessage(
      body: messageBody,
      userId: userManager.user.id,
      createdAt: new DateTime.now().millisecondsSinceEpoch,
    );

    messageManager.sendMessage(message);
  }
}
