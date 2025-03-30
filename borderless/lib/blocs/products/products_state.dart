import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final String? currentCategory;
  final String? currentSort;
  final String? currentSearch;

  const ProductsLoaded({
    required this.products,
    this.currentCategory,
    this.currentSort,
    this.currentSearch,
  });

  @override
  List<Object> get props => [
        products,
        currentCategory ?? '',
        currentSort ?? '',
        currentSearch ?? '',
      ];

  ProductsLoaded copyWith({
    List<Product>? products,
    String? currentCategory,
    String? currentSort,
    String? currentSearch,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      currentCategory: currentCategory ?? this.currentCategory,
      currentSort: currentSort ?? this.currentSort,
      currentSearch: currentSearch ?? this.currentSearch,
    );
  }
}

class ProductDetailsLoaded extends ProductsState {
  final Product product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}
