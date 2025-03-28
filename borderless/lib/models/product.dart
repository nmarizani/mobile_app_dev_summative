import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final String category;
  final List<Color> colors;
  final bool isAvailable;
  final bool isFavorite;
  final double? discountPercentage;
  final List<String>? sizes;
  final double? rating;
  final int? reviews;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    required this.category,
    this.colors = const [],
    this.isAvailable = true,
    this.isFavorite = false,
    this.discountPercentage,
    this.sizes,
    this.rating,
    this.reviews,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        oldPrice,
        imageUrl,
        category,
        colors,
        isAvailable,
        isFavorite,
        discountPercentage,
        sizes,
        rating,
        reviews,
      ];

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? oldPrice,
    String? imageUrl,
    String? category,
    List<Color>? colors,
    bool? isAvailable,
    bool? isFavorite,
    double? discountPercentage,
    List<String>? sizes,
    double? rating,
    int? reviews,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      colors: colors ?? this.colors,
      isAvailable: isAvailable ?? this.isAvailable,
      isFavorite: isFavorite ?? this.isFavorite,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      sizes: sizes ?? this.sizes,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
    );
  }

  double get discountedPrice {
    if (discountPercentage == null) return price;
    return price * (1 - discountPercentage! / 100);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'imageUrl': imageUrl,
      'colors': colors.map((color) => color.value).toList(),
      'sizes': sizes,
      'rating': rating,
      'reviews': reviews,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      oldPrice: json['oldPrice']?.toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      colors: (json['colors'] as List)
          .map((colorValue) => Color(colorValue))
          .toList(),
      isAvailable: json['isAvailable'] ?? true,
      isFavorite: json['isFavorite'] ?? false,
      discountPercentage: json['discountPercentage']?.toDouble(),
      sizes: json['sizes']?.cast<String>(),
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
    );
  }
}
