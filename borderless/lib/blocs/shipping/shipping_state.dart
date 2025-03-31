import 'package:equatable/equatable.dart';

class ShippingAddress extends Equatable {
  final String? fullName;
  final String? phoneNumber;
  final String? province;
  final String? city;
  final String? streetAddress;
  final String? postalCode;

  const ShippingAddress({
    this.fullName,
    this.phoneNumber,
    this.province,
    this.city,
    this.streetAddress,
    this.postalCode,
  });

  ShippingAddress copyWith({
    String? fullName,
    String? phoneNumber,
    String? province,
    String? city,
    String? streetAddress,
    String? postalCode,
  }) {
    return ShippingAddress(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      province: province ?? this.province,
      city: city ?? this.city,
      streetAddress: streetAddress ?? this.streetAddress,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        phoneNumber,
        province,
        city,
        streetAddress,
        postalCode,
      ];
}

class ShippingState extends Equatable {
  final ShippingAddress address;
  final bool isLoading;
  final String? error;

  const ShippingState({
    this.address = const ShippingAddress(),
    this.isLoading = false,
    this.error,
  });

  ShippingState copyWith({
    ShippingAddress? address,
    bool? isLoading,
    String? error,
  }) {
    return ShippingState(
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [address, isLoading, error];
}
