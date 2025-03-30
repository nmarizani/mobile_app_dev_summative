import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'exclusive_sale_screen.dart' as exclusive;
import '../models/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> recentSearches = [
    'Smart watch',
    'Laptop',
    'Women bag',
    'Headphones',
    'Shoes',
    'Eye glasses',
  ];

  // Mock search results
  final List<Product> _searchResults = [
    Product(
      id: '1',
      name: 'Nike Air Max 270',
      description: 'Men\'s Running Shoes',
      price: 150.00,
      imageUrl: 'assets/images/nike_shoes.png',
      category: 'Shoes',
      colors: [Colors.black, Colors.white, Colors.red],
      isAvailable: true,
      rating: 4.5,
      reviews: 128,
    ),
    Product(
      id: '2',
      name: 'Ray-Ban Sunglasses',
      description: 'Classic Aviator Style',
      price: 199.99,
      imageUrl: 'assets/images/glasses.png',
      category: 'Accessories',
      colors: [Colors.black, Colors.grey],
      isAvailable: true,
      rating: 4.3,
      reviews: 95,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _navigateToExclusiveSale() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const exclusive.ExclusiveSaleScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/filter.svg',
              width: 24,
              height: 24,
            ),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF21D4B4)),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _navigateToExclusiveSale();
                }
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'RECENT SEARCH',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: recentSearches.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return _buildRecentSearchItem(recentSearches[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchItem(String search) {
    return InkWell(
      onTap: () {
        _searchController.text = search;
        _navigateToExclusiveSale();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.history,
              color: Colors.grey[400],
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                search,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _selectedSort = 'Price (High to Low)';
  final List<String> _sortOptions = [
    'Price (Low to High)',
    'Price (High to Low)',
    'A-Z',
    'Z-A',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200]!,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _sortOptions.length,
            itemBuilder: (context, index) {
              final option = _sortOptions[index];
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedSort,
                onChanged: (value) {
                  setState(() {
                    _selectedSort = value!;
                  });
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Apply'),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
