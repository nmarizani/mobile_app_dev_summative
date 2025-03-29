import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExclusiveSaleScreen extends StatelessWidget {
  const ExclusiveSaleScreen({super.key});

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
        title: const Text(
          'Exclusive Sale',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/filter.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Show filter
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Show search
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: _demoProducts.length,
        itemBuilder: (context, index) {
          final product = _demoProducts[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(ExclusiveProduct product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    product.colors.length,
                    (index) => Container(
                      width: 16,
                      height: 16,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: product.colors[index],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF21D4B4),
                  ),
                ),
                if (product.originalPrice != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '\$${product.originalPrice!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExclusiveProduct {
  final String name;
  final String image;
  final double price;
  final double? originalPrice;
  final List<Color> colors;

  const ExclusiveProduct({
    required this.name,
    required this.image,
    required this.price,
    this.originalPrice,
    required this.colors,
  });
}

final List<ExclusiveProduct> _demoProducts = [
  ExclusiveProduct(
    name: 'Loop silicone strong headphones',
    image: 'assets/images/headphones1.png',
    price: 15.25,
    originalPrice: 25.00,
    colors: [Colors.black, Colors.blue, Colors.red],
  ),
  ExclusiveProduct(
    name: 'K800 Ultra smart watch',
    image: 'assets/images/watch1.png',
    price: 32.00,
    colors: [Colors.black, Colors.grey],
  ),
  ExclusiveProduct(
    name: 'P47 Wireless headphones',
    image: 'assets/images/headphones2.png',
    price: 38.45,
    colors: [Colors.blue, Colors.red, Colors.black],
  ),
  ExclusiveProduct(
    name: 'MX IP47 headphones',
    image: 'assets/images/headphones3.png',
    price: 12.00,
    originalPrice: 20.00,
    colors: [Colors.orange, Colors.black, Colors.grey],
  ),
  ExclusiveProduct(
    name: 'D20 Bluetooth smart headphones',
    image: 'assets/images/headphones4.png',
    price: 25.25,
    originalPrice: 30.00,
    colors: [Colors.blue, Colors.orange, Colors.black],
  ),
  ExclusiveProduct(
    name: 'D18s Smart headphones',
    image: 'assets/images/headphones5.png',
    price: 17.15,
    originalPrice: 20.50,
    colors: [Colors.black, Colors.grey],
  ),
];
