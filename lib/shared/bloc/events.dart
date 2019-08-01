import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class IAction<P> {
  P payload;
  IAction(P payload) {
    this.payload = payload;
  }
}

abstract class IFeatureBloc<E, S, M extends IMapEvent<S, E>> extends Bloc<E, S> {
  S get initialState;
  M get mapEvent;
  // void handleEvent(E event);
  BuildContext context;

  final PublishSubject<E> events = PublishSubject<E>();

  @override
  void onEvent(E event) {
    events.add(event);
  }

  @override
  Stream<S> mapEventToState(E e) => mapEvent != null ? mapEvent.mapEvent(currentState, e) : null;
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
