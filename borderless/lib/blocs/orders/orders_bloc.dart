import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order.dart';
import 'orders_event.dart';
import 'orders_state.dart';
import 'package:flutter/material.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<LoadOrders>(_onLoadOrders);
    on<CreateOrder>(_onCreateOrder);
    on<UpdateOrderStatus>(_onUpdateOrderStatus);
    on<CancelOrder>(_onCancelOrder);
  }

  Future<void> _onLoadOrders(
    LoadOrders event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(OrdersLoading());
      // TODO: Implement actual orders loading logic
      // For now, we'll use mock data
      await Future.delayed(const Duration(seconds: 1));
      final mockOrders = [
        Order(
          id: '1',
          userId: 'user1',
          items: [],
          total: 0,
          status: 'pending',
          createdAt: DateTime.now(),
          shippingAddress: '123 Main St',
          paymentMethod: 'Credit Card',
        ),
      ];
      emit(OrdersLoaded(mockOrders));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _onCreateOrder(
    CreateOrder event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      emit(OrdersLoading());
      // TODO: Implement actual order creation logic
      await Future.delayed(const Duration(seconds: 1));
      final newOrder = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: event.userId,
        items: event.items,
        total: event.total,
        status: 'pending',
        createdAt: DateTime.now(),
        shippingAddress: event.shippingAddress,
        paymentMethod: event.paymentMethod,
      );
      emit(OrderCreated(newOrder));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _onUpdateOrderStatus(
    UpdateOrderStatus event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is OrdersLoaded) {
        emit(OrdersLoading());
        // TODO: Implement actual order status update logic
        await Future.delayed(const Duration(seconds: 1));
        final updatedOrders = currentState.orders.map((order) {
          if (order.id == event.orderId) {
            return order.copyWith(status: event.status);
          }
          return order;
        }).toList();
        emit(OrdersLoaded(updatedOrders));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> _onCancelOrder(
    CancelOrder event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is OrdersLoaded) {
        emit(OrdersLoading());
        // TODO: Implement actual order cancellation logic
        await Future.delayed(const Duration(seconds: 1));
        final updatedOrders = currentState.orders
            .where((order) => order.id != event.orderId)
            .toList();
        emit(OrdersLoaded(updatedOrders));
      }
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
