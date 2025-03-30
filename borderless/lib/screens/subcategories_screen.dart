import 'package:flutter/material.dart';

class SubcategoriesScreen extends StatelessWidget {
  final String category;

  const SubcategoriesScreen({super.key, required this.category});

  Map<String, List<String>> getSubcategories() {
    switch (category.toLowerCase()) {
      case 'fashion':
        return {
          'Clothing': ['Men', 'Women', 'Kids', 'Accessories'],
          'Footwear': ['Sneakers', 'Boots', 'Sandals', 'Formal'],
          'Jewelry': ['Necklaces', 'Rings', 'Bracelets', 'Earrings'],
          'Bags': ['Handbags', 'Backpacks', 'Wallets', 'Luggage'],
        };
      case 'electronics':
        return {
          'Smartphones': ['Android', 'iOS', 'Accessories'],
          'Computers': ['Laptops', 'Desktops', 'Tablets'],
          'Audio': ['Headphones', 'Speakers', 'Microphones'],
          'Gaming': ['Consoles', 'Games', 'Accessories'],
        };
      case 'furniture':
        return {
          'Living Room': ['Sofas', 'Tables', 'Storage', 'Decor'],
          'Bedroom': ['Beds', 'Wardrobes', 'Nightstands', 'Mattresses'],
          'Office': ['Desks', 'Chairs', 'Storage', 'Accessories'],
          'Outdoor': ['Patio', 'Garden', 'Outdoor Decor'],
        };
      case 'fabrication':
        return {
          'Metal': ['Steel', 'Aluminum', 'Custom Work'],
          'Plastic': ['Injection Molding', 'Custom Parts'],
          'Wood': ['Custom Furniture', 'Cabinets', 'Millwork'],
          '3D Printing': ['Prototypes', 'Custom Parts', 'Design Services'],
        };
      case 'industrial':
        return {
          'Machinery': ['Heavy Equipment', 'Tools', 'Parts'],
          'Safety': ['PPE', 'Safety Equipment', 'Training'],
          'Materials': ['Raw Materials', 'Supplies', 'Consumables'],
          'Services': ['Maintenance', 'Repair', 'Consulting'],
        };
      case 'electrical':
        return {
          'Components': ['Wiring', 'Circuit Breakers', 'Switches'],
          'Lighting': ['LED', 'Fixtures', 'Controls'],
          'Tools': ['Test Equipment', 'Hand Tools', 'Power Tools'],
          'Safety': ['Protection', 'Testing', 'Compliance'],
        };
      case 'construction':
        return {
          'Materials': ['Concrete', 'Steel', 'Timber', 'Insulation'],
          'Tools': ['Power Tools', 'Hand Tools', 'Safety Equipment'],
          'Equipment': ['Heavy Machinery', 'Scaffolding', 'Lifting'],
          'Services': ['Contractors', 'Consultants', 'Project Management'],
        };
      case 'home decor':
        return {
          'Lighting': ['Chandeliers', 'Lamps', 'Wall Sconces'],
          'Textiles': ['Curtains', 'Rugs', 'Bedding', 'Cushions'],
          'Art': ['Paintings', 'Prints', 'Sculptures', 'Wall Art'],
          'Accessories': ['Mirrors', 'Vases', 'Clocks', 'Decorative Items'],
        };
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final subcategories = getSubcategories();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          final categoryName = subcategories.keys.elementAt(index);
          final items = subcategories[categoryName]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: items.length,
                itemBuilder: (context, itemIndex) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigate to product listing screen
                        Navigator.pushNamed(
                          context,
                          '/products',
                          arguments: {
                            'category': category,
                            'subcategory': categoryName,
                            'item': items[itemIndex],
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIconForSubcategory(categoryName),
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              items[itemIndex],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _getIconForSubcategory(String subcategory) {
    switch (subcategory.toLowerCase()) {
      case 'clothing':
        return Icons.checkroom;
      case 'footwear':
        return Icons.shopping_bag;
      case 'jewelry':
        return Icons.diamond;
      case 'bags':
        return Icons.backpack;
      case 'smartphones':
        return Icons.phone_android;
      case 'computers':
        return Icons.computer;
      case 'audio':
        return Icons.headphones;
      case 'gaming':
        return Icons.games;
      case 'living room':
        return Icons.living;
      case 'bedroom':
        return Icons.bed;
      case 'office':
        return Icons.work;
      case 'outdoor':
        return Icons.landscape;
      case 'metal':
        return Icons.construction;
      case 'plastic':
        return Icons.polymer;
      case 'wood':
        return Icons.forest;
      case '3d printing':
        return Icons.print;
      case 'machinery':
        return Icons.build;
      case 'safety':
        return Icons.security;
      case 'materials':
        return Icons.inventory;
      case 'services':
        return Icons.engineering;
      case 'components':
        return Icons.electric_bolt;
      case 'lighting':
        return Icons.lightbulb;
      case 'tools':
        return Icons.handyman;
      case 'art':
        return Icons.palette;
      case 'textiles':
        return Icons.curtains;
      case 'accessories':
        return Icons.home;
      default:
        return Icons.category;
    }
  }
}
