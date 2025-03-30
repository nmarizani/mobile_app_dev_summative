import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_listing/product_listing_bloc.dart';
import '../blocs/product_listing/product_listing_event.dart';
import '../blocs/product_listing/product_listing_state.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import '../blocs/wishlist/wishlist_bloc.dart';

class ProductListingScreen extends StatefulWidget {
  final String categoryId;
  final String subcategoryId;
  final String title;

  const ProductListingScreen({
    super.key,
    required this.categoryId,
    required this.subcategoryId,
    required this.title,
  });

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<Map<String, dynamic>> watches = [
    {
      'name': "Loop Silicone Smartwatch",
      'price': 15.25,
      'oldPrice': 20.00,
      'image': 'assets/loop_silicone.png',
      'liked': false
    },
    {
      'name': "K800 Ultra Smart Watch",
      'price': 32.00,
      'oldPrice': 55.00,
      'image': 'assets/k800_ultra.png',
      'liked': false
    },
    {
      'name': "Waterproof Sport M4",
      'price': 8.95,
      'oldPrice': 15.00,
      'image': 'assets/sport_m4.png',
      'liked': false
    },
    {
      'name': "M6 Smart Watch IP67",
      'price': 12.00,
      'oldPrice': 18.00,
      'image': 'assets/m6_smart.png',
      'liked': false
    },
    {
      'name': "Classic Silver Watch",
      'price': 45.00,
      'oldPrice': 60.00,
      'image': 'assets/classic_silver.png',
      'liked': false
    },
    {
      'name': "Smart Fitness Band",
      'price': 20.00,
      'oldPrice': 30.00,
      'image': 'assets/fitness_band.png',
      'liked': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // ✅ Updated to show correct title
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: watches.length,
        itemBuilder: (context, index) {
          return _buildWatchCard(index);
        },
      ),
    );
  }

  Widget _buildWatchCard(int index) {
    final watch = watches[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const ProductDetailScreen(), // ✅ Adjust if necessary
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.asset(watch['image'], height: 120),
            Text(watch['name']),
            Text("\$${watch['price']}"),
            BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
              final isWishlisted = state.wishlistItems
                  .any((item) => item['name'] == watch['name']);
              return IconButton(
                  icon: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted ? Colors.red : null),
                  onPressed: () {
                    if (isWishlisted) {
                      context
                          .read<WishlistBloc>()
                          .add(RemoveFromWishlist(watch['name']));
                    } else {
                      context.read<WishlistBloc>().add(AddToWishlist(watch));
                    }
                  });
            })
          ],
        ),
      ),
    );
  }
}
