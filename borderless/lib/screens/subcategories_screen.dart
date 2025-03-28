import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/animated_widgets.dart';
import '../widgets/bottom_nav_bar.dart';

class SubcategoriesScreen extends StatelessWidget {
  final Category category;

  const SubcategoriesScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Category> _subcategories = [
      Category(
        id: '1',
        name: 'Laptops',
        iconAsset: 'assets/images/laptop.png',
      ),
      Category(
        id: '2',
        name: 'Mobile phones',
        iconAsset: 'assets/images/mobile.png',
      ),
      Category(
        id: '3',
        name: 'Headphones',
        iconAsset: 'assets/images/headphones.png',
      ),
      Category(
        id: '4',
        name: 'Smart Watches',
        iconAsset: 'assets/images/smartwatch.png',
      ),
      Category(
        id: '5',
        name: 'Mobile Cases',
        iconAsset: 'assets/images/case.png',
      ),
      Category(
        id: '6',
        name: 'Monitors',
        iconAsset: 'assets/images/monitor.png',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: ScaleOnTap(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              title: Text(
                category.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final subcategory = _subcategories[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to products
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              child: Image.asset(
                                subcategory.iconAsset!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subcategory.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: _subcategories.length,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
