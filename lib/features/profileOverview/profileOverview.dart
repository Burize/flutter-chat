import 'package:flutter/material.dart';

import './bloc/bloc.dart';
import './view/containers/account.dart';
import '../../core/dependency.dart';

class ProfileOverview {
  ProfileOverviewBloc _bloc;

  ProfileOverview() {
    _bloc = DI.get<ProfileOverviewBloc>();
  }

  Widget accountView() {
    return AccountView(bloc: _bloc);
  }
}
