import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  static const String _cartKey = 'cart_items';
  static const String _savedItemsKey = 'saved_items';

  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<SaveForLater>(_onSaveForLater);
    on<MoveToCart>(_onMoveToCart);
    on<RemoveSavedItem>(_onRemoveSavedItem);
    on<ClearCart>(_onClearCart);
    on<LoadCart>(_onLoadCart);

    // Load cart state when bloc is created
    add(LoadCart());
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final cartJson = prefs.getString(_cartKey);
      final savedItemsJson = prefs.getString(_savedItemsKey);

      final cartItems = cartJson != null
          ? (jsonDecode(cartJson) as List)
              .map((item) => CartItem.fromJson(item))
              .toList()
          : <CartItem>[];

      final savedItems = savedItemsJson != null
          ? (jsonDecode(savedItemsJson) as List)
              .map((item) => CartItem.fromJson(item))
              .toList()
          : <CartItem>[];

      emit(CartState(
        items: cartItems,
        savedItems: savedItems,
      ));
    } catch (e) {
      // Handle error
      print('Error loading cart: $e');
    }
  }

  Future<void> _saveCartState(CartState state) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final cartJson =
          jsonEncode(state.items.map((item) => item.toJson()).toList());
      final savedItemsJson =
          jsonEncode(state.savedItems.map((item) => item.toJson()).toList());

      await prefs.setString(_cartKey, cartJson);
      await prefs.setString(_savedItemsKey, savedItemsJson);
    } catch (e) {
      // Handle error
      print('Error saving cart: $e');
    }
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    final existingIndex = currentItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (existingIndex >= 0) {
      currentItems[existingIndex] = currentItems[existingIndex].copyWith(
        quantity: currentItems[existingIndex].quantity + event.quantity,
      );
    } else {
      currentItems.add(CartItem(
        product: event.product,
        quantity: event.quantity,
        selectedSize: event.selectedSize,
        selectedColor: event.selectedColor,
        imageUrl: event.imageUrl,
      ));
    }

    final newState = state.copyWith(items: currentItems);
    emit(newState);
    _saveCartState(newState);
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items)
      ..removeWhere((item) => item.product.id == event.productId);
    final newState = state.copyWith(items: currentItems);
    emit(newState);
    _saveCartState(newState);
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    if (event.quantity <= 0) {
      add(RemoveFromCart(event.productId));
      return;
    }

    final currentItems = List<CartItem>.from(state.items);
    final index = currentItems.indexWhere(
      (item) => item.product.id == event.productId,
    );

    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(
        quantity: event.quantity,
      );
      final newState = state.copyWith(items: currentItems);
      emit(newState);
      _saveCartState(newState);
    }
  }

  void _onSaveForLater(SaveForLater event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    final currentSavedItems = List<CartItem>.from(state.savedItems);

    final itemToSave = currentItems.firstWhere(
      (item) => item.product.id == event.productId,
    );

    currentItems.removeWhere((item) => item.product.id == event.productId);
    currentSavedItems.add(itemToSave.copyWith(isSavedForLater: true));

    final newState = state.copyWith(
      items: currentItems,
      savedItems: currentSavedItems,
    );
    emit(newState);
    _saveCartState(newState);
  }

  void _onMoveToCart(MoveToCart event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    final currentSavedItems = List<CartItem>.from(state.savedItems);

    final itemToMove = currentSavedItems.firstWhere(
      (item) => item.product.id == event.productId,
    );

    currentSavedItems.removeWhere((item) => item.product.id == event.productId);
    currentItems.add(itemToMove.copyWith(isSavedForLater: false));

    final newState = state.copyWith(
      items: currentItems,
      savedItems: currentSavedItems,
    );
    emit(newState);
    _saveCartState(newState);
  }

  void _onRemoveSavedItem(RemoveSavedItem event, Emitter<CartState> emit) {
    final currentSavedItems = List<CartItem>.from(state.savedItems)
      ..removeWhere((item) => item.product.id == event.productId);
    final newState = state.copyWith(savedItems: currentSavedItems);
    emit(newState);
    _saveCartState(newState);
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    final newState = const CartState();
    emit(newState);
    _saveCartState(newState);
  }
}
