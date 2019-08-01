import './namespace.dart';
import '../../../shared/bloc/communication.dart';

class ProfileState implements IProfileState {
  ICommunication<String> changingName;
  ICommunication<String> changingPhone;
  ICommunication<String> changingAvatar;

  ProfileState.fromState(ProfileState state) {
    changingName = state.changingName;
    changingPhone = state.changingPhone;
    changingAvatar = state.changingAvatar;
  }

  ProfileState.initial() {
    changingName = ICommunication<String>.initial();
    changingPhone = ICommunication<String>.initial();
    changingAvatar = ICommunication<String>.initial();
  }
}
