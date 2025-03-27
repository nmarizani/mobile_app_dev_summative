import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/animated_widgets.dart';
import 'product_detail_screen.dart';

class ProductListingScreen extends StatefulWidget {
  final String title;

  const ProductListingScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String _selectedSort = 'All';
  final List<String> _filters = [
    'All',
    'Popular',
    'Latest',
    'Top Rated',
  ];

  // Mock data
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Loop silicone strap',
      price: 15.25,
      imageUrl: 'assets/images/watch_strap1.png',
      description: 'High-quality silicone strap for smart watches.',
      colors: [Colors.black, Colors.blue, Colors.purple],
    ),
    Product(
      id: '2',
      name: 'K800 Ultra smart watch',
      price: 32.00,
      imageUrl: 'assets/images/watch2.png',
      description: 'Ultra-thin smart watch with advanced features.',
      colors: [Colors.black, Colors.grey, Colors.white],
    ),
    Product(
      id: '3',
      name: 'Waterproof sport M4 t...',
      price: 8.95,
      imageUrl: 'assets/images/watch3.png',
      description: 'Waterproof sports tracker with heart rate monitoring.',
      colors: [Colors.black, Colors.blue, Colors.red],
    ),
    Product(
      id: '4',
      name: 'M6 Smart watch IP67',
      price: 12.00,
      imageUrl: 'assets/images/watch4.png',
      description: 'IP67 waterproof smart watch with fitness tracking.',
      colors: [Colors.black, Colors.orange, Colors.grey, Colors.white],
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
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                ScaleOnTap(
                  onTap: () {
                    // Open search screen
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
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = filter == _selectedSort;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedSort = filter;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey[300]!,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
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
