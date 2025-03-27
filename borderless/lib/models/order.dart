import 'package:equatable/equatable.dart';
import 'product.dart';

class Order extends Equatable {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime createdAt;
  final String shippingAddress;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.shippingAddress,
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [
        id,
        userId,
        items,
        total,
        status,
        createdAt,
        shippingAddress,
        paymentMethod,
      ];

  Order copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    double? total,
    String? status,
    DateTime? createdAt,
    String? shippingAddress,
    String? paymentMethod,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class OrderItem extends Equatable {
  final Product product;
  final int quantity;
  final double price;

  const OrderItem({
    required this.product,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object> get props => [product, quantity, price];
}
