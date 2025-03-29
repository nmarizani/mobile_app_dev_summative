import 'package:flutter/material.dart';
import '../widgets/animated_widgets.dart';

class VoucherCodes {
  static final Map<String, double> codes = {
    'DISCOUNT10': 0.10, // 10% off
    'FREESHIP': 5.00, // $5 off for shipping
    'WELCOME20': 0.20, // 20% off for first-time users
  };

  static double? getDiscount(String code) {
    return codes[code];
  }
}
