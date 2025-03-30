import 'package:equatable/equatable.dart';

class ShippingAddress extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String streetAddress;
  final String province;
  final String city;
  final String postalCode;

  const ShippingAddress({
    this.fullName = '',
    this.phoneNumber = '',
    this.streetAddress = '',
    this.province = '',
    this.city = '',
    this.postalCode = '',
  });

  ShippingAddress copyWith({
    String? fullName,
    String? phoneNumber,
    String? streetAddress,
    String? province,
    String? city,
    String? postalCode,
  }) {
    return ShippingAddress(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      streetAddress: streetAddress ?? this.streetAddress,
      province: province ?? this.province,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        phoneNumber,
        streetAddress,
        province,
        city,
        postalCode,
      ];
}

class PaymentDetails extends Equatable {
  final String cardholderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String paymentMethod;

  const PaymentDetails({
    this.cardholderName = '',
    this.cardNumber = '',
    this.expiryDate = '',
    this.cvv = '',
    this.paymentMethod = 'card',
  });

  PaymentDetails copyWith({
    String? cardholderName,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    String? paymentMethod,
  }) {
    return PaymentDetails(
      cardholderName: cardholderName ?? this.cardholderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
        cardholderName,
        cardNumber,
        expiryDate,
        cvv,
        paymentMethod,
      ];
}

class OrderTracking extends Equatable {
  final String orderId;
  final String status;
  final DateTime estimatedDelivery;
  final List<OrderTrackingStep> steps;

  const OrderTracking({
    required this.orderId,
    required this.status,
    required this.estimatedDelivery,
    required this.steps,
  });

  OrderTracking copyWith({
    String? orderId,
    String? status,
    DateTime? estimatedDelivery,
    List<OrderTrackingStep>? steps,
  }) {
    return OrderTracking(
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      steps: steps ?? this.steps,
    );
  }

  @override
  List<Object?> get props => [orderId, status, estimatedDelivery, steps];
}

class OrderTrackingStep extends Equatable {
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isCompleted;

  const OrderTrackingStep({
    required this.title,
    required this.description,
    required this.timestamp,
    this.isCompleted = false,
  });

  OrderTrackingStep copyWith({
    String? title,
    String? description,
    DateTime? timestamp,
    bool? isCompleted,
  }) {
    return OrderTrackingStep(
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [title, description, timestamp, isCompleted];
}

class CheckoutState extends Equatable {
  final ShippingAddress shippingAddress;
  final PaymentDetails paymentDetails;
  final OrderTracking? orderTracking;
  final int currentStep;
  final String? error;

  const CheckoutState({
    this.shippingAddress = const ShippingAddress(),
    this.paymentDetails = const PaymentDetails(),
    this.orderTracking,
    this.currentStep = 1,
    this.error,
  });

  CheckoutState copyWith({
    ShippingAddress? shippingAddress,
    PaymentDetails? paymentDetails,
    OrderTracking? orderTracking,
    int? currentStep,
    String? error,
  }) {
    return CheckoutState(
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentDetails: paymentDetails ?? this.paymentDetails,
      orderTracking: orderTracking ?? this.orderTracking,
      currentStep: currentStep ?? this.currentStep,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        shippingAddress,
        paymentDetails,
        orderTracking,
        currentStep,
        error,
      ];
}
