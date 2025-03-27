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
        id: '1', name: 'Electronics', icon: 'assets/icons/electronics.png'),
    Category(id: '2', name: 'Fashion', icon: 'assets/icons/fashion.png'),
    Category(id: '3', name: 'Furniture', icon: 'assets/icons/furniture.png'),
    Category(id: '4', name: 'Industrial', icon: 'assets/icons/industrial.png'),
    Category(id: '5', name: 'Home Decor', icon: 'assets/icons/home_decor.png'),
    Category(
        id: '6', name: 'Electronics', icon: 'assets/icons/electronics_alt.png'),
    Category(id: '7', name: 'Health', icon: 'assets/icons/health.png'),
    Category(
        id: '8',
        name: 'Construction & Real Estate',
        icon: 'assets/icons/construction.png'),
    Category(
        id: '9',
        name: 'Fabrication Service',
        icon: 'assets/icons/fabrication.png'),
    Category(
        id: '10',
        name: 'Electrical Equipment',
        icon: 'assets/icons/electrical.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: FadeInWidget(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
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
                    final category = _categories[index];
                    return FadeInWidget(
                      delay: Duration(milliseconds: 100 * index),
                      child: ScaleOnTap(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubcategoriesScreen(category: category),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Image.asset(
                                  category.icon,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                category.name,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: _categories.length,
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
