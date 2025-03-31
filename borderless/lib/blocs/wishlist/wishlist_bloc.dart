import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistInitial()) {
    on<AddToWishlist>((event, emit) {
      try {
        if (state is WishlistLoaded) {
          final currentState = state as WishlistLoaded;
          final List<Product> updatedItems =
              List.from(currentState.items ?? []);
          if (!updatedItems.contains(event.product)) {
            updatedItems.add(event.product);
          }
          emit(WishlistLoaded(updatedItems));
        } else {
          emit(WishlistLoaded([event.product]));
        }
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<RemoveFromWishlist>((event, emit) {
      try {
        if (state is WishlistLoaded) {
          final currentState = state as WishlistLoaded;
          final List<Product> updatedItems = List.from(currentState.items ?? [])
            ..removeWhere((item) => item.id == event.productId);
          emit(WishlistLoaded(updatedItems));
        }
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });
  }
}
