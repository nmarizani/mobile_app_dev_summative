import 'package:flutter/material.dart';

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
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isOngoing
              ? 'We currently don\'t have any active orders in progress. Feel free to explore our products and place a new order.'
              : 'You haven\'t completed any orders yet. Start shopping now and explore our products.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to categories
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          if (isOngoing)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.red[400]),
                  const SizedBox(width: 4),
                  Text(
                    'Estimated time: ${order['estimatedTime']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          Row(
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
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00C566),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${order['originalPrice'].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (!isOngoing)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C566).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Finished',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF00C566),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        if (isOngoing)
                          GestureDetector(
                            onTap: () {
                              // Decrease quantity
                            },
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            order['quantity'].toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (isOngoing)
                          GestureDetector(
                            onTap: () {
                              // Increase quantity
                            },
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (!isOngoing)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    order['date'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Ongoing'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ongoing Orders Tab
          _ongoingOrders.isEmpty
              ? _buildEmptyState(isOngoing: true)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _ongoingOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderItem(_ongoingOrders[index], true);
                  },
                ),
          // Completed Orders Tab
          _completedOrders.isEmpty
              ? _buildEmptyState(isOngoing: false)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _completedOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderItem(_completedOrders[index], false);
                  },
                ),
        ],
      ),
    );
  }
}
