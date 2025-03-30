import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrdersEvent {}

class CreateOrder extends OrdersEvent {
  final String userId;
  final List<OrderItem> items;
  final double total;
  final String shippingAddress;
  final String paymentMethod;

  const CreateOrder({
    required this.userId,
    required this.items,
    required this.total,
    required this.shippingAddress,
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [
        userId,
        items,
        total,
        shippingAddress,
        paymentMethod,
      ];
}

class UpdateOrderStatus extends OrdersEvent {
  final String orderId;
  final String status;

  const UpdateOrderStatus(this.orderId, this.status);

  @override
  List<Object> get props => [orderId, status];
}

class CancelOrder extends OrdersEvent {
  final String orderId;

  const CancelOrder(this.orderId);

  @override
  List<Object> get props => [orderId];
}
