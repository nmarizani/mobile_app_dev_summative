import 'package:equatable/equatable.dart';
import 'shipping_state.dart';

abstract class ShippingEvent extends Equatable {
  const ShippingEvent();

  @override
  List<Object?> get props => [];
}

class UpdateShippingAddress extends ShippingEvent {
  final ShippingAddress address;

  const UpdateShippingAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class LoadSavedAddress extends ShippingEvent {}

class ClearShippingAddress extends ShippingEvent {}
