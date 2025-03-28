import 'dart:convert';
import 'package:flutter/material.dart';
import 'product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String selectedSize;
  final Color selectedColor;
  final String imageUrl;
  bool isSavedForLater;

  CartItem({
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
    required this.imageUrl,
    this.isSavedForLater = false,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedSize,
    Color? selectedColor,
    String? imageUrl,
    bool? isSavedForLater,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      imageUrl: imageUrl ?? this.imageUrl,
      isSavedForLater: isSavedForLater ?? this.isSavedForLater,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor.value,
      'imageUrl': imageUrl,
      'isSavedForLater': isSavedForLater,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      selectedSize: json['selectedSize'],
      selectedColor: Color(json['selectedColor']),
      imageUrl: json['imageUrl'],
      isSavedForLater: json['isSavedForLater'] ?? false,
    );
  }
}
