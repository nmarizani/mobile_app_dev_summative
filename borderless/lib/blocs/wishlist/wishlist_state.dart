import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class WishlistState extends Equatable {
  final List<Product> items;
  final bool isLoading;
  final String? error;

  const WishlistState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [items, isLoading, error];

  WishlistState copyWith({
    List<Product>? items,
    bool? isLoading,
    String? error,
  });
}

class WishlistInitial extends WishlistState {
  const WishlistInitial() : super();

  @override
  WishlistState copyWith({
    List<Product>? items,
    bool? isLoading,
    String? error,
  }) {
    return WishlistInitial();
  }
}

class WishlistLoading extends WishlistState {
  const WishlistLoading() : super(isLoading: true);

  @override
  WishlistState copyWith({
    List<Product>? items,
    bool? isLoading,
    String? error,
  }) {
    return WishlistLoading();
  }
}

class WishlistLoaded extends WishlistState {
  const WishlistLoaded({
    required List<Product> items,
    String? error,
  }) : super(
          items: items,
          isLoading: false,
          error: error,
        );

  @override
  WishlistState copyWith({
    List<Product>? items,
    bool? isLoading,
    String? error,
  }) {
    return WishlistLoaded(
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }
}

class WishlistError extends WishlistState {
  const WishlistError({required String error})
      : super(error: error, isLoading: false);

  @override
  WishlistState copyWith({
    List<Product>? items,
    bool? isLoading,
    String? error,
  }) {
    return WishlistError(error: error ?? this.error!);
  }
}
