import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  final List<String> wishlistItems; 

  const WishlistScreen({super.key, required this.wishlistItems});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Method to remove an item from the wishlist
  void removeItem(String item) {
    setState(() {
      widget.wishlistItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: widget.wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: widget.wishlistItems.length,
                itemBuilder: (context, index) {
                  String item = widget.wishlistItems.elementAt(index);
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/${item.toLowerCase().replaceAll(" ", "_")}.png',
                        width: 50,
                      ),
                      title: Text(
                        item,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(index == 0 ? '\$15.25' : '\$12.00',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.green)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeItem(item),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  // Widget to display when the wishlist is empty
  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_wishlist.png', width: 150),
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
