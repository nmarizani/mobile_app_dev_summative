import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../blocs/checkout/checkout_bloc.dart';
import '../blocs/checkout/checkout_state.dart';
import '../blocs/checkout/checkout_event.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late final Timer _refreshTimer;

  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(TrackOrder(widget.orderId));
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => context.read<CheckoutBloc>().add(TrackOrder(widget.orderId)),
    );
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    HapticFeedback.mediumImpact();
    context.read<CheckoutBloc>().add(TrackOrder(widget.orderId));
    // Wait for the state to update
    await Future.delayed(const Duration(seconds: 1));
  }

  void _shareOrderStatus(OrderTracking tracking) {
    HapticFeedback.selectionClick();
    final status = tracking.status;
    final orderId = tracking.orderId;
    final estimatedDelivery =
        DateFormat('EEEE, MMMM d').format(tracking.estimatedDelivery);

    final shareText = '''
📦 Order Status Update

Order ID: $orderId
Status: $status
Estimated Delivery: $estimatedDelivery

Track your order at: [Your App URL]/track/$orderId
''';

    Share.share(shareText);
  }

  IconData _getStepIcon(String title) {
    switch (title.toLowerCase()) {
      case 'order placed':
        return Icons.shopping_cart_checkout;
      case 'processing':
        return Icons.inventory;
      case 'shipped':
        return Icons.local_shipping;
      case 'out for delivery':
        return Icons.delivery_dining;
      case 'delivered':
        return Icons.home;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Order Tracking',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {
              final state = context.read<CheckoutBloc>().state;
              if (state.orderTracking != null) {
                _shareOrderStatus(state.orderTracking!);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              HapticFeedback.selectionClick();
              context.read<CheckoutBloc>().add(TrackOrder(widget.orderId));
            },
          ),
        ],
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state.orderTracking == null) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: Colors.black,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderInfo(state.orderTracking!),
                  const SizedBox(height: 24),
                  _buildTrackingSteps(state.orderTracking!.steps),
                  // Add extra space at bottom for pull to refresh
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderInfo(OrderTracking tracking) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 20,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Order ID: ${tracking.orderId}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(tracking.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(tracking.status),
                      size: 16,
                      color: _getStatusColor(tracking.status),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tracking.status,
                      style: TextStyle(
                        color: _getStatusColor(tracking.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 20,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Delivery',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEEE, MMMM d')
                        .format(tracking.estimatedDelivery),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingSteps(List<OrderTrackingStep> steps) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween(begin: 0, end: step.isCompleted ? 1 : 0),
                    builder: (context, value, child) {
                      return Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.lerp(
                            Colors.white,
                            Colors.green,
                            value,
                          ),
                          border: Border.all(
                            color: Color.lerp(
                              Colors.grey[300]!,
                              Colors.green,
                              value,
                            )!,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            step.isCompleted
                                ? Icons.check
                                : _getStepIcon(step.title),
                            size: 16,
                            color: Color.lerp(
                              step.isCompleted
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              step.isCompleted
                                  ? Colors.white
                                  : Colors.grey[700],
                              value,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (!isLast)
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 500),
                      tween: Tween(begin: 0, end: step.isCompleted ? 1 : 0),
                      builder: (context, value, child) {
                        return Container(
                          width: 2,
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: Color.lerp(
                            Colors.grey[300],
                            Colors.green,
                            value,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('MMM d, h:mm a').format(step.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  if (!isLast) const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return Icons.inventory;
      case 'shipped':
        return Icons.local_shipping;
      case 'out for delivery':
        return Icons.delivery_dining;
      case 'delivered':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.orange;
      case 'out for delivery':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
