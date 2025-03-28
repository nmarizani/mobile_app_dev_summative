import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_listing/product_listing_bloc.dart';
import '../blocs/product_listing/product_listing_event.dart';
import '../blocs/product_listing/product_listing_state.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ProductListingScreen extends StatefulWidget {
  final String categoryId;
  final String subcategoryId;
  final String title;

  const ProductListingScreen({
    super.key,
    required this.categoryId,
    required this.subcategoryId,
    required this.title,
  });

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    context.read<ProductListingBloc>().add(
          LoadProducts(
            categoryId: widget.categoryId,
            subcategoryId: widget.subcategoryId,
          ),
        );
  }

  void _navigateToProductDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(
                  onSearch: (query) {
                    context.read<ProductListingBloc>().add(
                          SearchProducts(query),
                        );
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters) _buildFilterPanel(),
          Expanded(
            child: BlocBuilder<ProductListingBloc, ProductListingState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${state.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ProductListingBloc>().add(
                                  LoadProducts(
                                    categoryId: widget.categoryId,
                                    subcategoryId: widget.subcategoryId,
                                  ),
                                );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: state.products[index],
                      onTap: () =>
                          _navigateToProductDetail(state.products[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPanel() {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ProductListingBloc>().add(ClearFilters());
                      setState(() {
                        _showFilters = false;
                      });
                    },
                    child: const Text('Clear All'),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSortChip(state, 'Popular', 'popular'),
                    const SizedBox(width: 8),
                    _buildSortChip(state, 'Price: Low to High', 'price_low'),
                    const SizedBox(width: 8),
                    _buildSortChip(state, 'Price: High to Low', 'price_high'),
                    const SizedBox(width: 8),
                    _buildSortChip(state, 'Rating', 'rating'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Price Range',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              RangeSlider(
                values: RangeValues(
                  state.filters['price_range']?[0] ?? 0,
                  state.filters['price_range']?[1] ?? 1000,
                ),
                min: 0,
                max: 1000,
                divisions: 20,
                labels: RangeLabels(
                  '\$${(state.filters['price_range']?[0] ?? 0).toStringAsFixed(0)}',
                  '\$${(state.filters['price_range']?[1] ?? 1000).toStringAsFixed(0)}',
                ),
                onChanged: (RangeValues values) {
                  context.read<ProductListingBloc>().add(
                        FilterProducts({
                          ...state.filters,
                          'price_range': [values.start, values.end],
                        }),
                      );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Rating',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(
                  5,
                  (index) => _buildRatingChip(state, index + 1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortChip(ProductListingState state, String label, String value) {
    final isSelected = state.sortBy == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          context.read<ProductListingBloc>().add(SortProducts(value));
        }
      },
      selectedColor: const Color(0xFF21D4B4),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildRatingChip(ProductListingState state, int rating) {
    final isSelected = state.filters['rating'] == rating.toDouble();
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$rating'),
            const SizedBox(width: 4),
            Icon(
              Icons.star,
              size: 16,
              color: isSelected ? Colors.white : Colors.amber,
            ),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          context.read<ProductListingBloc>().add(
                FilterProducts({
                  ...state.filters,
                  'rating': selected ? rating.toDouble() : null,
                }),
              );
        },
        selectedColor: const Color(0xFF21D4B4),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<String> {
  final Function(String) onSearch;

  ProductSearchDelegate({required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return Container(); // Results will be shown in the main screen
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 2) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Type to search products',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    onSearch(query);
    return Container(); // Suggestions will be shown in the main screen
  }

  @override
  String get searchFieldLabel => 'Search products';

  @override
  TextStyle get searchFieldStyle => const TextStyle(
        fontSize: 16,
        color: Colors.black,
      );
}
