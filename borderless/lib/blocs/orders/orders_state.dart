import 'package:equatable/equatable.dart';
import '../../models/order.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];

  OrdersLoaded copyWith({
    List<Order>? orders,
  }) {
    return OrdersLoaded(orders ?? this.orders);
  }
}

class OrderCreated extends OrdersState {
  final Order order;

  const OrderCreated(this.order);

  @override
  List<Object> get props => [order];
}

class OrderUpdated extends OrdersState {
  final Order order;

  const OrderUpdated(this.order);

  @override
  List<Object> get props => [order];
}

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object> get props => [message];
}
