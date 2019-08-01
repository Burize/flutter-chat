import './namespace.dart';
import './state.dart';
import '../../../shared/bloc/communication.dart';
import '../../../shared/bloc/events.dart';

class PrfileMapEvents extends IMapEvent<ProfileState, IProfileEvents> {
  TMapEventToState<ProfileState, IProfileEvents> get mapEvent => (s, e) async* {
        final next = ProfileState.fromState(s);

        if (e is ChangeName) {
          yield next..changingName = ICommunication<String>.execute();
          return;
        }

        if (e is ChangeNameSuccess) {
          yield next..changingName = ICommunication<String>.complete();
          return;
        }

        if (e is ChangeNameFail) {
          yield next..changingName = ICommunication<String>.fail(e.payload);
          return;
        }

        if (e is ChangePhone) {
          yield next..changingPhone = ICommunication<String>.execute();
          return;
        }

        if (e is ChangePhoneSuccess) {
          yield next..changingPhone = ICommunication<String>.complete();
          return;
        }

        if (e is ChangePhoneFail) {
          yield next..changingPhone = ICommunication<String>.fail(e.payload);
          return;
        }

        if (e is ChangeAvatar) {
          yield next..changingAvatar = ICommunication<String>.execute();
          return;
        }

        if (e is ChangeAvatarSuccess) {
          yield next..changingAvatar = ICommunication<String>.complete();
          return;
        }

        if (e is ChangeAvatarFail) {
          yield next..changingAvatar = ICommunication<String>.fail(e.payload);
          return;
        }
      };
}
