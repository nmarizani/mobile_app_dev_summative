import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    try {
      final currentState = state;
      if (currentState is CartLoaded) {
        final updatedItems = Map<Product, int>.from(currentState.items);
        updatedItems[event.product] =
            (updatedItems[event.product] ?? 0) + event.quantity;

        final total = _calculateTotal(updatedItems);
        emit(CartLoaded(items: updatedItems, total: total));
      } else {
        emit(CartLoaded(
          items: {event.product: event.quantity},
          total: event.product.price * event.quantity,
        ));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    try {
      final currentState = state;
      if (currentState is CartLoaded) {
        final updatedItems = Map<Product, int>.from(currentState.items)
          ..remove(event.product);

        final total = _calculateTotal(updatedItems);
        emit(CartLoaded(items: updatedItems, total: total));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    try {
      final currentState = state;
      if (currentState is CartLoaded) {
        final updatedItems = Map<Product, int>.from(currentState.items);
        if (event.quantity > 0) {
          updatedItems[event.product] = event.quantity;
        } else {
          updatedItems.remove(event.product);
        }

        final total = _calculateTotal(updatedItems);
        emit(CartLoaded(items: updatedItems, total: total));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartLoaded());
  }

  double _calculateTotal(Map<Product, int> items) {
    return items.entries
        .fold(0.0, (total, entry) => total + (entry.key.price * entry.value));
  }
}
