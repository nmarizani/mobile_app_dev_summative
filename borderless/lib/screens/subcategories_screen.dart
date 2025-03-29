import 'package:flutter/material.dart';
import '../models/category.dart';
import 'product_listing_screen.dart';

class SubcategoriesScreen extends StatelessWidget {
  final Category category;

  SubcategoriesScreen({
    super.key,
    required this.category,
  });

  // Sample subcategories for Electronics
  final List<Map<String, String>> _electronicsSubcategories = [
    {
      'id': 'laptops',
      'name': 'Laptops',
      'image': 'assets/images/subcategories/laptops.jpg',
    },
    {
      'id': 'mobile_phones',
      'name': 'Mobile phones',
      'image': 'assets/images/subcategories/mobile_phones.jpg',
    },
    {
      'id': 'headphones',
      'name': 'Headphones',
      'image': 'assets/images/subcategories/headphones.jpg',
    },
    {
      'id': 'smart_watches',
      'name': 'Smart Watches',
      'image': 'assets/images/subcategories/smart_watches.jpg',
    },
    {
      'id': 'mobile_cases',
      'name': 'Mobile Cases',
      'image': 'assets/images/subcategories/mobile_cases.jpg',
    },
    {
      'id': 'monitors',
      'name': 'Monitors',
      'image': 'assets/images/subcategories/monitors.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          category.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // TODO: Navigate to search screen
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
          childAspectRatio: 1,
        ),
        itemCount: _electronicsSubcategories.length,
        itemBuilder: (context, index) {
  final subcategory = _electronicsSubcategories[index];
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductListingScreen(
            categoryId: category.id,
            subcategoryId: subcategory['id']!,
            title: subcategory['name']!,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(subcategory['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subcategory['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
