import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Product> products;

  const WishlistLoaded(this.products);

  @override
  List<Object> get props => [products];

  WishlistLoaded copyWith({
    List<Product>? products,
  }) {
    return WishlistLoaded(products ?? this.products);
  }
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object> get props => [message];
}
