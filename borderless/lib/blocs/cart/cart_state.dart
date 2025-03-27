import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Map<Product, int> items;
  final double total;

  const CartLoaded({
    this.items = const {},
    this.total = 0.0,
  });

  @override
  List<Object> get props => [items, total];

  CartLoaded copyWith({
    Map<Product, int>? items,
    double? total,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
