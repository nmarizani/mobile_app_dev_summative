import 'package:equatable/equatable.dart';
import '../../models/product.dart';

class ProductListingState extends Equatable {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final String sortBy;
  final Map<String, dynamic> filters;
  final String searchQuery;

  const ProductListingState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.sortBy = 'popular',
    this.filters = const {},
    this.searchQuery = '',
  });

  ProductListingState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
    String? sortBy,
    Map<String, dynamic>? filters,
    String? searchQuery,
  }) {
    return ProductListingState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sortBy: sortBy ?? this.sortBy,
      filters: filters ?? this.filters,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        products,
        isLoading,
        error,
        sortBy,
        filters,
        searchQuery,
      ];
}
