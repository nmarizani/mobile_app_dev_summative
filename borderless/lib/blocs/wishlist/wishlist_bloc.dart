import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Event
abstract class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToWishlist extends WishlistEvent {
  final Map<String, dynamic> product;

  AddToWishlist(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromWishlist extends WishlistEvent {
  final String productName;

  RemoveFromWishlist(this.productName);

  @override
  List<Object> get props => [productName];
}

// State
class WishlistState extends Equatable {
  final List<Map<String, dynamic>> wishlistItems;

  const WishlistState(this.wishlistItems);

  @override
  List<Object> get props => [wishlistItems];
}

// BLoC
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistState([])) {
    on<AddToWishlist>((event, emit) {
      final updatedWishlist = List<Map<String, dynamic>>.from(state.wishlistItems);
      updatedWishlist.add(event.product);
      emit(WishlistState(updatedWishlist));
    });

    on<RemoveFromWishlist>((event, emit) {
      final updatedWishlist = state.wishlistItems.where((item) => item['name'] != event.productName).toList();
      emit(WishlistState(updatedWishlist));
    });
  }
}





