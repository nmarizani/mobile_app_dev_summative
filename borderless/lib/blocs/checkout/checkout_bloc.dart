import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const CheckoutState()) {
    on<UpdateShippingAddress>(_onUpdateShippingAddress);
    on<UpdatePaymentDetails>(_onUpdatePaymentDetails);
    on<PlaceOrder>(_onPlaceOrder);
    on<TrackOrder>(_onTrackOrder);
    on<UpdateCheckoutStep>(_onUpdateCheckoutStep);
    on<ClearCheckoutError>(_onClearCheckoutError);
  }

  void _onUpdateShippingAddress(
    UpdateShippingAddress event,
    Emitter<CheckoutState> emit,
  ) {
    emit(state.copyWith(shippingAddress: event.shippingAddress));
  }

  void _onUpdatePaymentDetails(
    UpdatePaymentDetails event,
    Emitter<CheckoutState> emit,
  ) {
    emit(state.copyWith(paymentDetails: event.paymentDetails));
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<CheckoutState> emit,
  ) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
      final now = DateTime.now();

      final orderTracking = OrderTracking(
        orderId: orderId,
        status: 'Processing',
        estimatedDelivery: now.add(const Duration(days: 5)),
        steps: [
          OrderTrackingStep(
            title: 'Order Placed',
            description: 'Your order has been placed successfully',
            timestamp: now,
            isCompleted: true,
          ),
          OrderTrackingStep(
            title: 'Processing',
            description: 'Your order is being processed',
            timestamp: now.add(const Duration(hours: 2)),
            isCompleted: false,
          ),
          OrderTrackingStep(
            title: 'Shipped',
            description: 'Your order has been shipped',
            timestamp: now.add(const Duration(days: 2)),
            isCompleted: false,
          ),
          OrderTrackingStep(
            title: 'Out for Delivery',
            description: 'Your order is out for delivery',
            timestamp: now.add(const Duration(days: 4)),
            isCompleted: false,
          ),
          OrderTrackingStep(
            title: 'Delivered',
            description: 'Your order has been delivered',
            timestamp: now.add(const Duration(days: 5)),
            isCompleted: false,
          ),
        ],
      );

      emit(state.copyWith(
        orderTracking: orderTracking,
        currentStep: 3,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onTrackOrder(
    TrackOrder event,
    Emitter<CheckoutState> emit,
  ) async {
    try {
      // Simulate API call to get order tracking details
      await Future.delayed(const Duration(seconds: 1));

      if (state.orderTracking == null) {
        throw Exception('Order not found');
      }

      // Simulate order progress
      final now = DateTime.now();
      final steps = state.orderTracking!.steps.map((step) {
        return step.copyWith(
          isCompleted: step.timestamp.isBefore(now),
        );
      }).toList();

      final currentStatus = steps.lastWhere((step) => step.isCompleted).title;

      emit(state.copyWith(
        orderTracking: state.orderTracking!.copyWith(
          status: currentStatus,
          steps: steps,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onUpdateCheckoutStep(
    UpdateCheckoutStep event,
    Emitter<CheckoutState> emit,
  ) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _onClearCheckoutError(
    ClearCheckoutError event,
    Emitter<CheckoutState> emit,
  ) {
    emit(state.copyWith(error: null));
  }
}
