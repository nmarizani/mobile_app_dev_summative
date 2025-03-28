import 'package:equatable/equatable.dart';
import 'checkout_state.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateShippingAddress extends CheckoutEvent {
  final ShippingAddress shippingAddress;

  const UpdateShippingAddress(this.shippingAddress);

  @override
  List<Object?> get props => [shippingAddress];
}

class UpdatePaymentDetails extends CheckoutEvent {
  final PaymentDetails paymentDetails;

  const UpdatePaymentDetails(this.paymentDetails);

  @override
  List<Object?> get props => [paymentDetails];
}

class PlaceOrder extends CheckoutEvent {
  const PlaceOrder();
}

class TrackOrder extends CheckoutEvent {
  final String orderId;

  const TrackOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class UpdateCheckoutStep extends CheckoutEvent {
  final int step;

  const UpdateCheckoutStep(this.step);

  @override
  List<Object?> get props => [step];
}

class ClearCheckoutError extends CheckoutEvent {
  const ClearCheckoutError();
}
