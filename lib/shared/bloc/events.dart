import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

abstract class IAction<P> {
  P payload;
  IAction(P payload) {
    this.payload = payload;
  }
}

abstract class IFeatureBloc<E, S, M extends IMapEvent<S, E>>
    extends Bloc<E, S> {
  S get initialState;
  M get mapEvent;
  BuildContext context;

  @override
  Stream<S> mapEventToState(E e) =>
      mapEvent != null ? mapEvent.mapEvent(currentState, e) : null;
}

typedef void TDispatch<E>(E event);

abstract class IBlocAction<E> {
  assignDispatch(TDispatch<E> dispatch) {
    this.dispatch = dispatch;
  }

  TDispatch<E> dispatch;
}

typedef Stream<S> TMapEventToState<S, E>(S s, E e);

abstract class IMapEvent<S, E> {
  TMapEventToState<S, E> get mapEvent;
}

typedef void TUpdateStateMethod<S>(S state);

// class BlocListener<B extends Bloc, S> {
//   B bloc;
//   BlocListener(B bloc, [TUpdateStateMethod<S> updateStateMethod]) {
//     this.bloc = bloc;
//     (this.bloc.state as Stream<S>).listen((S state) {
//       if (updateStateMethod != null) {
//         updateStateMethod(state);
//       }
//     });
//   }
// }
