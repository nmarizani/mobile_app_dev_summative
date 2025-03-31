import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // Add this import for UserProvider
import '../models/category.dart';
import '../models/product.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/animated_widgets.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import 'categories_screen.dart';
import 'product_listing_screen.dart';
import 'search_screen.dart';
import 'exclusive_sales_screen.dart';
import 'auth/sign_up_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'profile/profile_screen.dart';
import '../widgets/logo.dart';
import 'product_detail_screen.dart';
import '../../main.dart'; // Import UserProvider from main.dart

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBanner = 0;

  final List<Map<String, String>> _banners = [
    {
      'image': 'assets/images/banner.png',
      'title': 'Exclusive Sales',
      'subtitle': '30% OFF on headphones',
    },
    {
      'image': 'assets/images/banner.png',
      'title': 'New Collection',
      'subtitle': 'Smart Watches & Accessories',
    },
  ];

  final List<Category> _categories = [
    Category(
      id: '1',
      name: 'Electronics',
      imageUrl: 'assets/icons/electronics.png',
    ),
    Category(
      id: '2',
      name: 'Fashion',
      imageUrl: 'assets/icons/fashion.png',
    ),
    Category(
      id: '3',
      name: 'Furniture',
      imageUrl: 'assets/icons/furniture.png',
    ),
    Category(
      id: '4',
      name: 'Industrial',
      imageUrl: 'assets/icons/industrial.png',
    ),
    Category(
      id: '5',
      name: 'Home Decor',
      imageUrl: 'assets/icons/home_decor.png',
    ),
    Category(
      id: '7',
      name: 'Construction & Real Estate',
      imageUrl: 'assets/icons/construction.png',
    ),
    Category(
      id: '8',
      name: 'Fabrication Service',
      imageUrl: 'assets/icons/fabrication.png',
    ),
    Category(
      id: '9',
      name: 'Electrical Equipment',
      imageUrl: 'assets/icons/electrical_equipment.png',
    ),
  ];

  final List<Product> _latestProducts = [
    Product(
      id: '1',
      name: 'Nike air Jordan retro fa...',
      price: 126.00,
      imageUrl: 'assets/images/nike_shoes.png',
      description: 'Nike air Jordan retro fashion',
      category: 'Fashion',
      colors: [Colors.black, Colors.red, Colors.green],
      discountPercentage: 30,
    ),
    Product(
      id: '2',
      name: 'Classic new black glas...',
      price: 8.50,
      imageUrl: 'assets/images/glasses.png',
      description: 'Classic new black glasses',
      category: 'Fashion',
      colors: [Colors.black, Colors.brown, Colors.grey],
    ),
    Product(
      id: '3',
      name: 'Apple Watch Series 8',
      price: 399.00,
      imageUrl: 'assets/images/smartwatch.png',
      description: 'Latest Apple Watch with advanced health features',
      category: 'Electronics',
      colors: [Colors.black, Colors.grey[300]!, Colors.amber],
      discountPercentage: 15,
    ),
    Product(
      id: '4',
      name: 'Modern Leather Backpack',
      price: 89.99,
      imageUrl: 'assets/images/backpack.png',
      description: 'Premium leather backpack with laptop compartment',
      category: 'Fashion',
      colors: [Colors.brown, Colors.black, Colors.brown[200]!],
      discountPercentage: 20,
    ),
    Product(
      id: '5',
      name: 'Wireless Earbuds Pro',
      price: 149.99,
      imageUrl: 'assets/images/earbuds.png',
      description: 'High-quality wireless earbuds with noise cancellation',
      category: 'Electronics',
      colors: [Colors.white, Colors.black, Colors.blue],
      discountPercentage: 25,
    ),
    Product(
      id: '6',
      name: 'Designer Crossbody Bag',
      price: 199.99,
      imageUrl: 'assets/images/handbag.png',
      description: 'Elegant designer crossbody bag for everyday use',
      category: 'Fashion',
      colors: [Colors.brown[100]!, Colors.black, Colors.red],
      discountPercentage: 30,
    ),
  ];

  Map<String, bool> _favoriteStates = {};

  @override
  void initState() {
    super.initState();
    // Initialize favorite states
    for (var product in _latestProducts) {
      _favoriteStates[product.id] = product.isFavorite;
    }
  }

  void _toggleFavorite(String productId) {
    setState(() {
      _favoriteStates[productId] = !(_favoriteStates[productId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Logo(size: 28),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
          children: [
            // Welcome Message using UserProvider
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), // Adjusted padding
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return Text(
                    userProvider.user != null
                        ? 'Welcome, ${userProvider.user!.email!.split('@')[0]}!' // Use email prefix as a simple greeting
                        : 'Welcome, Guest!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey[600]),
                      const SizedBox(width: 12),
                      Text(
                        'Search products...',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Banner Section
            AspectRatio(
              aspectRatio: 1.5,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: _banners.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentBanner = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final banner = _banners[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ExclusiveSalesScreen()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(banner['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.3),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  banner['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  banner['subtitle']!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Row(
                      children: List.generate(
                        _banners.length,
                            (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentBanner == index
                                ? const Color(0xFF21D4B4)
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoriesScreen()),
                          );
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductListingScreen(
                                  categoryId: category.id,
                                  subcategoryId: '',
                                  title: category.name,
                                  products: _latestProducts
                                      .map((product) => {
                                    'name': product.name,
                                    'price': product.price,
                                    'oldPrice': product.oldPrice,
                                    'image': product.imageUrl,
                                    'description': product.description,
                                    'specs': [
                                      'Specification 1',
                                      'Specification 2',
                                      'Specification 3'
                                    ],
                                  })
                                      .toList(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  category.imageUrl,
                                  width: 48,
                                  height: 48,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Latest Products Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductListingScreen(
                                categoryId: 'all',
                                subcategoryId: '',
                                title: 'Latest Products',
                                products: _latestProducts
                                    .map((product) => {
                                  'name': product.name,
                                  'price': product.price,
                                  'oldPrice': product.oldPrice,
                                  'image': product.imageUrl,
                                  'description': product.description,
                                  'specs': [
                                    'Specification 1',
                                    'Specification 2',
                                    'Specification 3'
                                  ],
                                })
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _latestProducts.length,
                    itemBuilder: (context, index) {
                      final product = _latestProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                category: product.category,
                                subcategory: '',
                                item: product.name,
                              ),
                            ),
                          );
                        },
                        child: _buildProductCard(product),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: AssetImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      _favoriteStates[product.id] ?? false
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _favoriteStates[product.id] ?? false
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(product.id),
                  ),
                ),
                if (product.discountPercentage != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF21D4B4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product.discountPercentage}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (product.discountPercentage != null) ...[
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                          ],
                          Text(
                            '\$${(product.price * (1 - (product.discountPercentage ?? 0) / 100)).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF21D4B4),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}