import 'package:flutter_bloc/flutter_bloc.dart';
import 'shipping_event.dart';
import 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  ShippingBloc() : super(const ShippingState()) {
    on<UpdateShippingAddress>(_onUpdateShippingAddress);
    on<LoadSavedAddress>(_onLoadSavedAddress);
    on<ClearShippingAddress>(_onClearShippingAddress);
  }

  void _onUpdateShippingAddress(
    UpdateShippingAddress event,
    Emitter<ShippingState> emit,
  ) {
    emit(state.copyWith(address: event.address));
  }

  Future<void> _onLoadSavedAddress(
    LoadSavedAddress event,
    Emitter<ShippingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      // TODO: Load saved address from local storage or API
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load saved address',
      ));
    }
  }

  void _onClearShippingAddress(
    ClearShippingAddress event,
    Emitter<ShippingState> emit,
  ) {
    emit(const ShippingState());
  }
}
