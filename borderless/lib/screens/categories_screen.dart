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
        iconAsset: 'assets/icons/electronics.png'),
    Category(id: '2', name: 'Fashion', iconAsset: 'assets/icons/fashion.png'),
    Category(
        id: '3', name: 'Furniture', iconAsset: 'assets/icons/furniture.png'),
    Category(
        id: '4', name: 'Industrial', iconAsset: 'assets/icons/industrial.png'),
    Category(
        id: '5', name: 'Home Decor', iconAsset: 'assets/icons/home_decor.png'),
    Category(
        id: '6',
        name: 'Electronics',
        iconAsset: 'assets/icons/electronics_alt.png'),
    Category(id: '7', name: 'Health', iconAsset: 'assets/icons/health.png'),
    Category(
        id: '8',
        name: 'Construction & Real Estate',
        iconAsset: 'assets/icons/construction.png'),
    Category(
        id: '9',
        name: 'Fabrication Service',
        iconAsset: 'assets/icons/fabrication.png'),
    Category(
        id: '10',
        name: 'Electrical Equipment',
        iconAsset: 'assets/icons/electrical.png'),
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
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return ScaleOnTap(
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
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 32,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
