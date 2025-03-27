import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/animated_widgets.dart';

class SubcategoriesScreen extends StatelessWidget {
  final Category category;

  const SubcategoriesScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data
    final List<Category> subcategories = [
      Category(
          id: '1', name: 'Smartphones', icon: 'assets/icons/smartphone.png'),
      Category(id: '2', name: 'Laptops', icon: 'assets/icons/laptop.png'),
      Category(id: '3', name: 'Tablets', icon: 'assets/icons/tablet.png'),
      Category(
          id: '4', name: 'Accessories', icon: 'assets/icons/accessories.png'),
      Category(id: '5', name: 'Cameras', icon: 'assets/icons/camera.png'),
      Category(id: '6', name: 'Audio', icon: 'assets/icons/audio.png'),
    ];

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
              title: FadeInWidget(
                child: Text(
                  category.name,
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
                    final subcategory = subcategories[index];
                    return FadeInWidget(
                      delay: Duration(milliseconds: 100 * index),
                      child: ScaleOnTap(
                        onTap: () {
                          // Navigate to products
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
                                  subcategory.icon,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                subcategory.name,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: subcategories.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
