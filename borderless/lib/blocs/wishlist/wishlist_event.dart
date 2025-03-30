import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class WishlistEvent {}

class LoadWishlist extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final String item;
  AddToWishlist(this.item);
}

class RemoveFromWishlist extends WishlistEvent {
  final String item;
  RemoveFromWishlist(this.item);
}

class ClearWishlist extends WishlistEvent {}
