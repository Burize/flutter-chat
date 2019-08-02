import 'package:flutter/material.dart';

import './bloc/bloc.dart';
import './view/containers/account.dart';
import '../../core/service_locator.dart';

class ProfileOverview {
  ProfileOverviewBloc _bloc;

  ProfileOverview() {
    _bloc = SL.get<ProfileOverviewBloc>();
  }

  Widget accountView() {
    return AccountView(bloc: _bloc);
  }
}
