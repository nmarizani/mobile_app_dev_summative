import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedSort = 'Price (High to Low)';
                  });
                },
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _sortOptions.map((option) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(option),
                    selected: _selectedSort == option,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedSort = option;
                        });
                      }
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF21D4B4).withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: _selectedSort == option
                          ? const Color(0xFF21D4B4)
                          : Colors.black,
                      fontSize: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: _selectedSort == option
                            ? const Color(0xFF21D4B4)
                            : Colors.grey[300]!,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedSort);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF21D4B4),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
