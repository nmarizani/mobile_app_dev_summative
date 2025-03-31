import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class WishlistState extends Equatable {
  final List<Product>? items;

  const WishlistState({this.items});

  @override
  List<Object?> get props => [items];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial() : super(items: const []);
}

class WishlistLoading extends WishlistState {
  const WishlistLoading() : super();
}

class WishlistLoaded extends WishlistState {
  const WishlistLoaded(List<Product> items) : super(items: items);
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message) : super();

  @override
  List<Object?> get props => [message, items];
}
