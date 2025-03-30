import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/wishlist/wishlist_bloc.dart' as bloc;
import '../blocs/wishlist/wishlist_event.dart' as event;

abstract class WishlistState {
  final Set<String> wishlistItems;
  final bool isLoading;
  final String? error;

  const WishlistState({
    this.wishlistItems = const {},
    this.isLoading = false,
    this.error,
  });
}

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

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error!),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WishlistBloc>().add(LoadWishlist());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.wishlistItems.isEmpty) {
            return _buildEmptyWishlist(context);
          }

          return ListView.builder(
            itemCount: state.wishlistItems.length,
            itemBuilder: (context, index) {
              final item = state.wishlistItems.elementAt(index);
              return ListTile(
                title: Text(item),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<WishlistBloc>().add(RemoveFromWishlist(item));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/empty_wishlist.png', width: 150),
          const SizedBox(height: 20),
          const Text(
            'Your wishlist is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Tap heart button to start saving your favorite items.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/categories');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: const Text('Explore Categories',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistInitial()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    on<ClearWishlist>(_onClearWishlist);
  }
  // ... implement event handlers
}
