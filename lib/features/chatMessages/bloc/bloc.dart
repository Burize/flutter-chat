import '../../../core/dependency.dart';
import '../../../shared/bloc/events.dart';

import './namespace.dart';
import './state.dart';
import './state_map_event.dart';
import './externals.dart';

class ChatBloc extends IFeatureBloc<IChatEvents, ChatState, AuthMapEvents> {
  final ChatState _initialState = ChatState.initial();
  ChatState get initialState => _initialState;

  final AuthMapEvents _mapEvent = AuthMapEvents();
  AuthMapEvents get mapEvent => _mapEvent;

  ChatBloc() {
    final messageManager = DI.get<IChatMessageManagerContract>();
    messageManager.subscribe(_onNewMessage);
  }

  Future<void> _onNewMessage(String message) async {
    dispatch(NewMessage(Message(body: message)));
  }
}
