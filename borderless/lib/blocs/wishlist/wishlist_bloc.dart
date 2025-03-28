import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistInitial()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<ClearWishlist>(_onClearWishlist);
  }

  void _onLoadWishlist(LoadWishlist event, Emitter<WishlistState> emit) async {
    emit(const WishlistLoading());
    try {
      // TODO: Load wishlist from storage
      await Future.delayed(const Duration(seconds: 1));
      emit(const WishlistLoaded(items: []));
    } catch (e) {
      emit(WishlistError(error: e.toString()));
    }
  }

  void _onAddToWishlist(AddToWishlist event, Emitter<WishlistState> emit) {
    if (state is WishlistLoaded) {
      final state = this.state as WishlistLoaded;
      try {
        emit(WishlistLoaded(
          items: [...state.items, event.product],
        ));
      } catch (e) {
        emit(WishlistError(error: e.toString()));
      }
    }
  }

  void _onRemoveFromWishlist(
      RemoveFromWishlist event, Emitter<WishlistState> emit) {
    if (state is WishlistLoaded) {
      final state = this.state as WishlistLoaded;
      try {
        emit(WishlistLoaded(
          items: [...state.items]
            ..removeWhere((item) => item.id == event.productId),
        ));
      } catch (e) {
        emit(WishlistError(error: e.toString()));
      }
    }
  }

  void _onClearWishlist(ClearWishlist event, Emitter<WishlistState> emit) {
    emit(state.copyWith(items: []));
  }
}
