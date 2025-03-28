import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/animated_widgets.dart';
import 'subcategories_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
      id: '6',
      name: 'Electronics',
      imageUrl: 'assets/icons/electronics_tv.png',
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
      imageUrl: 'assets/icons/electrical.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Categories',
          style: TextStyle(
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
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubcategoriesScreen(category: category),
                ),
              );
            },
            child: Container(
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
                  Container(
                    width: 56,
                    height: 56,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      category.imageUrl,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
