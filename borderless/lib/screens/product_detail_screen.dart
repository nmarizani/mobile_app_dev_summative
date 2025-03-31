import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final String category;
  final String subcategory;
  final String item;

  const ProductDetailScreen({
    super.key,
    required this.category,
    required this.subcategory,
    required this.item,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  int _quantity = 1;
  int _selectedColorIndex = 0;

  final List<String> _productImages = [
    'assets/images/products/loop_silicone.png',
    'assets/images/watch1.png',
    'assets/images/watch2.png',
    'assets/images/watch3.png',
  ];

  final List<Color> _availableColors = [
    Colors.black,
    Colors.blue,
    Colors.grey,
    Colors.purple,
    Colors.teal,
  ];

  String _generateDescription() {
    final category = widget.category.toLowerCase();
    final subcategory = widget.subcategory.toLowerCase();
    final item = widget.item;

    switch (category) {
      case 'electronics':
        return 'High-quality electronic device featuring the latest technology. This $item comes with advanced features and premium build quality, perfect for tech enthusiasts.';
      case 'fashion':
        return 'Trendy and stylish $item made with premium materials. Perfect for fashion-conscious individuals who appreciate quality and comfort.';
      case 'furniture':
        return 'Elegant and durable $item crafted with premium materials. This piece combines style with functionality, perfect for modern homes.';
      case 'industrial':
        return 'Professional-grade $item designed for industrial use. Built to last with high-quality materials and precise engineering.';
      case 'home decor':
        return 'Beautiful $item that adds elegance to any room. Carefully crafted with attention to detail and modern design principles.';
      case 'construction & real estate':
        return 'Professional construction-grade $item. Engineered for durability and performance in demanding construction environments.';
      case 'fabrication service':
        return 'Custom fabrication $item with precision engineering. Made to exact specifications using high-quality materials.';
      case 'electrical equipment':
        return 'High-performance electrical $item with safety certifications. Designed for reliable operation and long-term durability.';
      default:
        return 'Premium quality $item designed to meet your needs. Features excellent craftsmanship and attention to detail.';
    }
  }

  void _showAddToCartSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            const Text('Product has been added to your cart'),
            const Spacer(),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                Navigator.pushNamed(context, '/cart');
              },
              child: const Text(
                'View Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF21D4B4),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addToCart() {
    final product = Product(
      id: DateTime.now().toString(),
      name: widget.item,
      description: _generateDescription(),
      price: 15.25,
      imageUrl: 'assets/images/products/loop_silicone.png',
      category: widget.category,
      colors: _availableColors,
    );

    context.read<CartBloc>().add(
          AddToCart(
            product: product,
            quantity: _quantity,
            selectedSize: 'One Size',
            selectedColor: _availableColors[_selectedColorIndex],
            imageUrl: 'assets/images/products/loop_silicone.png',
          ),
        );

    _showAddToCartSuccess();
  }

  void _buyNow() {
    final product = Product(
      id: DateTime.now().toString(),
      name: widget.item,
      description: _generateDescription(),
      price: 15.25,
      imageUrl: 'assets/images/products/loop_silicone.png',
      category: widget.category,
      colors: _availableColors,
    );

    // Add to cart first
    context.read<CartBloc>().add(
          AddToCart(
            product: product,
            quantity: _quantity,
            selectedSize: 'One Size',
            selectedColor: _availableColors[_selectedColorIndex],
            imageUrl: 'assets/images/products/loop_silicone.png',
          ),
        );

    // Start the checkout flow from shipping
    Navigator.pushNamed(context, '/checkout-shipping');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: Colors.black),
                    onPressed: () => Navigator.pushNamed(context, '/cart'),
                  ),
                  if (state.items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF21D4B4),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          state.items.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image PageView
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 300,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemCount: _productImages.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              _productImages[index],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                      size: 32,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: _productImages.length,
                          effect: const WormEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            type: WormType.thin,
                            activeDotColor: Color(0xFF21D4B4),
                            dotColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Product Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Rating and Reviews
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < 4 ? Icons.star : Icons.star_half,
                                  color: const Color(0xFFFFB800),
                                  size: 18,
                                );
                              }),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(128 Reviews)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              '\$15.25',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF21D4B4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '\$20.00',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Color Options
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            _availableColors.length,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColorIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _selectedColorIndex == index
                                        ? const Color(0xFF21D4B4)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: _availableColors[index],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Quantity
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              _quantity.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Experience the perfect blend of style and functionality with our Loop Silicone Strong Magnetic Watch. This soft and flexible silicone strap provides a comfortable fit while the strong magnetic clasp ensures secure wear. The soft yet flexible silicone strap is perfect for all-day comfort and use.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _buyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text('Buy Now'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
