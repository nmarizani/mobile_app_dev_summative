import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/animated_widgets.dart';
import 'product_detail_screen.dart';

class ExclusiveSalesScreen extends StatefulWidget {
  const ExclusiveSalesScreen({Key? key}) : super(key: key);

  @override
  State<ExclusiveSalesScreen> createState() => _ExclusiveSalesScreenState();
}

class _ExclusiveSalesScreenState extends State<ExclusiveSalesScreen> {
  // Mock data
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Loop silicone strap headphones',
      price: 15.25,
      imageUrl: 'assets/images/headphone1.png',
      description: 'High-quality wireless headphones with noise cancellation.',
      colors: [Colors.black, Colors.blue],
    ),
    Product(
      id: '2',
      name: 'K800 Ultra headphones',
      price: 32.00,
      imageUrl: 'assets/images/headphone2.png',
      description: 'Premium wireless headphones with superior sound quality.',
      colors: [Colors.black, Colors.grey],
    ),
    Product(
      id: '3',
      name: 'P47 Wireless headphones',
      price: 8.95,
      imageUrl: 'assets/images/headphone3.png',
      description: 'Comfortable wireless headphones for everyday use.',
      colors: [Colors.black, Colors.blue, Colors.red],
    ),
    Product(
      id: '4',
      name: 'Elite Smart headphones',
      price: 12.00,
      imageUrl: 'assets/images/headphone4.png',
      description:
          'Smart headphones with touch controls and long battery life.',
      colors: [Colors.black, Colors.white],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: ScaleOnTap(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              title: Text(
                'Exclusive Sales',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                ScaleOnTap(
                  onTap: () {
                    // Open filter
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.tune, color: Colors.black),
                  ),
                ),
                ScaleOnTap(
                  onTap: () {
                    // Open search
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = _products[index];
                    final discountedPrice = product.price * 0.7; // 30% off
                    return FadeInWidget(
                      delay: Duration(milliseconds: 100 * index),
                      child: ScaleOnTap(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Hero(
                                        tag: 'product-${product.id}',
                                        child: Image.asset(
                                          product.imageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ...List.generate(
                                              product.colors.length,
                                              (index) => Container(
                                                width: 16,
                                                height: 16,
                                                margin: const EdgeInsets.only(
                                                    right: 4),
                                                decoration: BoxDecoration(
                                                  color: product.colors[index],
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'All ${product.colors.length} Colors',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '\$${discountedPrice.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '\$${product.price.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    product.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 20,
                                    color: product.isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    '30% OFF',
                                    style: TextStyle(
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
                      ),
                    );
                  },
                  childCount: _products.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
