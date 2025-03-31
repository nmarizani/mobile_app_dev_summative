import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _ongoingOrders = [
    {
      'name': 'Loop Silicone Strong Magnetic Watch',
      'price': 15.25,
      'originalPrice': 20.00,
      'image': 'assets/images/watch1.png',
      'quantity': 1,
      'estimatedTime': '7 working days',
    },
    {
      'name': 'M6 Smart watch IP67 Waterproof',
      'price': 12.00,
      'originalPrice': 18.90,
      'image': 'assets/images/watch2.png',
      'quantity': 1,
      'estimatedTime': '7 working days',
    },
  ];

  final List<Map<String, dynamic>> _completedOrders = [
    {
      'name': 'Loop Silicone Strong Magnetic Watch',
      'price': 15.25,
      'originalPrice': 20.00,
      'image': 'assets/images/watch1.png',
      'quantity': 1,
      'date': '7 July 2023',
      'status': 'Finished',
    },
    {
      'name': 'M6 Smart watch IP67 Waterproof',
      'price': 12.00,
      'originalPrice': 18.90,
      'image': 'assets/images/watch2.png',
      'quantity': 1,
      'date': '7 July 2023',
      'status': 'Finished',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildEmptyState({bool isOngoing = true}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 80),
        Image.asset(
          'assets/images/empty_orders.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 24),
        Text(
          isOngoing ? 'No ongoing order' : 'No completed order',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            isOngoing
                ? 'We currently don\'t have any active orders in progress. Feel free to explore our products and place a new order.'
                : 'We don\'t have any past orders that have been completed. Start shopping now and create your first order with us.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to categories
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Explore Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order, bool isOngoing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isOngoing)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8E8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Estimated time: ${order['estimatedTime']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFFF4B4B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  order['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '\$${order['price'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF21D4B4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${order['originalPrice'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    if (!isOngoing) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F3FF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Finished',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF2E7DFF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            order['date'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (isOngoing)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Decrease quantity
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove, size: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${order['quantity']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Increase quantity
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, size: 16),
                    ),
                  ),
                ],
              ),
            ),
        ],
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
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'Order History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _tabController.animateTo(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _tabController.index == 0
                            ? Colors.black
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Ongoing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _tabController.index == 0
                              ? Colors.white
                              : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _tabController.animateTo(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _tabController.index == 1
                            ? Colors.black
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Completed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _tabController.index == 1
                              ? Colors.white
                              : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ongoingOrders.isEmpty
                    ? _buildEmptyState(isOngoing: true)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _ongoingOrders.length,
                        itemBuilder: (context, index) {
                          return _buildOrderItem(_ongoingOrders[index], true);
                        },
                      ),
                _completedOrders.isEmpty
                    ? _buildEmptyState(isOngoing: false)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _completedOrders.length,
                        itemBuilder: (context, index) {
                          return _buildOrderItem(
                              _completedOrders[index], false);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }
}
