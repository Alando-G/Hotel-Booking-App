import 'package:flutter/material.dart';

class PaymentMethodsProvider with ChangeNotifier {
  final List<Map<String, String>> _paymentMethods = [];

  List<Map<String, String>> get paymentMethods => _paymentMethods;

  void addPaymentMethod(Map<String, String> paymentMethod) {
    _paymentMethods.add(paymentMethod);
    notifyListeners();
  }

  void removePaymentMethod(int index) {
    _paymentMethods.removeAt(index);
    notifyListeners();
  }
}
