import 'package:equatable/equatable.dart';

abstract class ProductListingEvent extends Equatable {
  const ProductListingEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductListingEvent {
  final String categoryId;
  final String subcategoryId;

  const LoadProducts({
    required this.categoryId,
    required this.subcategoryId,
  });

  @override
  List<Object?> get props => [categoryId, subcategoryId];
}

class SortProducts extends ProductListingEvent {
  final String sortBy;

  const SortProducts(this.sortBy);

  @override
  List<Object?> get props => [sortBy];
}

class FilterProducts extends ProductListingEvent {
  final Map<String, dynamic> filters;

  const FilterProducts(this.filters);

  @override
  List<Object?> get props => [filters];
}

class SearchProducts extends ProductListingEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearFilters extends ProductListingEvent {}
