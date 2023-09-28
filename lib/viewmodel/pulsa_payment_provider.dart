import 'package:flutter/material.dart';

class PulsaPaymentProvider with ChangeNotifier {
  String _paymentMethods = '';
  String get paymentMethods => _paymentMethods;

  void setpaymentMethods(String index) {
    _paymentMethods = index;
    notifyListeners();
  }
}
