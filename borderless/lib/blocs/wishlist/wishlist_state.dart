import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class WishlistState {
  final Set<String> wishlistItems;
  final bool isLoading;
  final String? error;

  const WishlistState({
    this.wishlistItems = const {},
    this.isLoading = false,
    this.error,
  });

  WishlistState copyWith({
    Set<String>? wishlistItems,
    bool? isLoading,
    String? error,
  });
}

class WishlistInitial extends WishlistState {
  const WishlistInitial() : super();

  @override
  WishlistState copyWith({
    Set<String>? wishlistItems,
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
    Set<String>? wishlistItems,
    bool? isLoading,
    String? error,
  }) {
    return WishlistLoading();
  }
}

class WishlistLoaded extends WishlistState {
  const WishlistLoaded({
    required Set<String> wishlistItems,
  }) : super(wishlistItems: wishlistItems);

  @override
  WishlistState copyWith({
    Set<String>? wishlistItems,
    bool? isLoading,
    String? error,
  }) {
    return WishlistLoaded(
      wishlistItems: wishlistItems ?? this.wishlistItems,
    );
  }
}

class WishlistError extends WishlistState {
  const WishlistError(String error) : super(error: error);

  @override
  WishlistState copyWith({
    Set<String>? wishlistItems,
    bool? isLoading,
    String? error,
  }) {
    return WishlistError(error ?? this.error!);
  }
}
