import 'package:flutter/widgets.dart';

import '../../../shared/bloc/communication.dart';
import '../../../shared/bloc/events.dart';

typedef void TOnAuthenticate(BuildContext context);

abstract class IProfileState {
  ICommunication<String> changingName;
}

abstract class IProfileEvents<P> extends IAction<P> {
  IProfileEvents(P payload) : super(payload);
}

class ChangeName extends IProfileEvents {
  ChangeName() : super(null);
}

class ChangeNameSuccess extends IProfileEvents {
  ChangeNameSuccess() : super(null);
}

class ChangeNameFail extends IProfileEvents<String> {
  ChangeNameFail(String error) : super(error);
}

class ChangePhone extends IProfileEvents {
  ChangePhone() : super(null);
}

class ChangePhoneSuccess extends IProfileEvents {
  ChangePhoneSuccess() : super(null);
}

class ChangePhoneFail extends IProfileEvents<String> {
  ChangePhoneFail(String error) : super(error);
}

class ChangeAvatar extends IProfileEvents {
  ChangeAvatar() : super(null);
}

class ChangeAvatarSuccess extends IProfileEvents {
  ChangeAvatarSuccess() : super(null);
}

class ChangeAvatarFail extends IProfileEvents<String> {
  ChangeAvatarFail(String error) : super(error);
}
