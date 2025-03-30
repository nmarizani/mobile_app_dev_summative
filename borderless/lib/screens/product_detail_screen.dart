import 'package:flutter/material.dart';
import 'my_cart_screen.dart'; // Import My Cart screen
import 'wishlist_screen.dart'; // Import Wishlist screen

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isLiked = false;
  int cartCount = 0;
  bool showSuccessMessage = false;


  Map<String, int> cartItems = {}; // Cart storage
  List<String> wishlist = []; // Wishlist storage

void toggleWishlist() {
  setState(() {
    if (isLiked) {
      wishlist.remove('Loop Silicone Smartwatch'); // Remove from wishlist
    } else {
      wishlist.add('Loop Silicone Smartwatch'); // Add to wishlist
    }
    isLiked = !isLiked;
  });

  // Navigate to wishlist if item is added
  if (isLiked) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WishlistScreen(wishlistItems: wishlist), // ✅ Fix: Use List<String>
      ),
    );
  }
}


  void addToCart() {
    setState(() {
      cartItems['Loop Silicone Smartwatch'] =
          (cartItems['Loop Silicone Smartwatch'] ?? 0) + 1;
      cartCount++;
      showSuccessMessage = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showSuccessMessage = false;
      });
    });
  }

  void buyNow() {
    addToCart();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyCartPage(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.black,
            ),
            onPressed: toggleWishlist, // ✅ Call toggleWishlist function
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/loop_silicone.png', height: 180),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Loop Silicone Strong \nMagnetic Watch',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('\$15.25',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    Text(
                      '\$20.00',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.orange, size: 18),
                Icon(Icons.star, color: Colors.orange, size: 18),
                Icon(Icons.star, color: Colors.orange, size: 18),
                Icon(Icons.star, color: Colors.orange, size: 18),
                Icon(Icons.star_half, color: Colors.orange, size: 18),
                SizedBox(width: 5),
                Text('4.5 (420 Reviews)', style: TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Constructed with high-quality silicone material, the Loop Silicone Strong Magnetic Watch ensures a comfortable and secure fit on your wrist. The soft and flexible silicone is gentle on the skin, making it ideal for extended wear. Its lightweight design allows for a seamless blend of comfort and durability.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            const Text('Color',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              children: List.generate(
                  3, (index) => _buildColorDot(Colors.primaries[index])),
            ),
            const SizedBox(height: 15),
            if (showSuccessMessage)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'The product has been added to your cart',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: buyNow,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text('Buy Now',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: addToCart,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200),
                  child: const Row(
                    children: [
                      Icon(Icons.add_shopping_cart, color: Colors.black),
                      SizedBox(width: 5),
                      Text('Add To Cart',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCartPage(cartItems: cartItems),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Go to Cart',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
    );
  }
}
