import 'package:equatable/equatable.dart';
import '../../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final List<CartItem> savedItems;

  const CartState({
    this.items = const [],
    this.savedItems = const [],
  });

  double get subtotal =>
      items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

  double get shippingCost {
    if (subtotal >= 100) return 0; // Free shipping for orders over $100
    return 10; // Standard shipping cost
  }

  double get total => subtotal + shippingCost;
  double get totalAmount => total; // Alias for total to maintain compatibility

  int get itemCount => items.length;
  int get savedItemCount => savedItems.length;

  CartState copyWith({
    List<CartItem>? items,
    List<CartItem>? savedItems,
  }) {
    return CartState(
      items: items ?? this.items,
      savedItems: savedItems ?? this.savedItems,
    );
  }

  @override
  List<Object?> get props => [items, savedItems];
}
