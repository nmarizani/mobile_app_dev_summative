import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState);

  @override
  void onTransition(Transition<Event, State> transition) {
    super.onTransition(transition);
    // Add logging or other common functionality here
  }
}
