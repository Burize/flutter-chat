import 'package:flutter/widgets.dart';

import './namespace.dart';
import './state.dart';
import './state_map_event.dart';
import '../../../core/service_locator.dart';
import '../../../services/api/api.dart';
import '../../../services/user/user_manager.dart';
import '../../../shared/bloc/events.dart';

typedef void TOnAuthenticateSuccess();

class ProfileOverviewBloc extends IFeatureBloc<IProfileEvents, ProfileState, PrfileMapEvents> {
  TOnAuthenticateSuccess onAuthenticate;

  final ProfileState _initialState = ProfileState.initial();
  ProfileState get initialState => _initialState;

  final PrfileMapEvents _mapEvent = PrfileMapEvents();
  PrfileMapEvents get mapEvent => _mapEvent;

  BuildContext replacementContext;

  Future<void> changeName(String firstName, String secondName) async {
    try {
      dispatch(ChangeName());
      final api = SL.get<Api>();
      final userManager = SL.get<UserManager>();

      final user = await api.user.updateUser(userManager.user.id, firstName: firstName, secondName: secondName);
      await userManager.saveUser(user);

      dispatch(ChangeNameSuccess());
    } catch (e) {
      dispatch(ChangeNameFail(e));
    }
  }

  Future<void> changePhone(String phone) async {
    try {
      dispatch(ChangePhone());
      final api = SL.get<Api>();
      final userManager = SL.get<UserManager>();

      final user = await api.user.updateUser(userManager.user.id, phone: phone);
      await userManager.saveUser(user);

      dispatch(ChangePhoneSuccess());
    } catch (e) {
      dispatch(ChangePhoneFail(e));
    }
  }

  Future<void> changeAvatar(String avatar) async {
    try {
      dispatch(ChangeAvatar());
      final api = SL.get<Api>();
      final userManager = SL.get<UserManager>();

      final avatarPath = await api.user.updateUserAvatar(userManager.user.id, avatar);
      final user = userManager.user;
      user.avatar = avatarPath;
      await userManager.saveUser(user);

      dispatch(ChangeAvatarSuccess());
    } catch (e) {
      dispatch(ChangeAvatarFail(e));
    }
  }
}
