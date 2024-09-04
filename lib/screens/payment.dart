import 'package:flutter/material.dart';
import 'package:login_signup/screens/card_details.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, String>> _paymentMethods = [
    {'type': 'Card', 'details': '**** **** **** 1234'},
    {'type': 'PayPal', 'details': 'example@example.com'},
    {'type': 'Google Pay', 'details': '**** **** 9876'},
  ];

  void _addPaymentMethod() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildPaymentMethodSelector(context),
    );
  }

  void _onPaymentMethodSelected(String methodType) {
    Navigator.of(context).pop(); // Close the bottom sheet
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CardDetailsScreen(methodType: methodType),
      ),
    ).then((_) {
      // Refresh the list after adding a new payment method
      setState(() {});
    });
  }

  void _removePaymentMethod(int index) {
    setState(() {
      _paymentMethods.removeAt(index);
    });
  }

  Widget _buildPaymentMethodSelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.credit_card, color: Colors.blueAccent),
            title: const Text('Credit/Debit Card'),
            onTap: () => _onPaymentMethodSelected('Card'),
          ),
          ListTile(
            leading: const Icon(Icons.paypal, color: Colors.blueAccent),
            title: const Text('PayPal'),
            onTap: () => _onPaymentMethodSelected('PayPal'),
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.blueAccent),
            title: const Text('Google Pay'),
            onTap: () => _onPaymentMethodSelected('Google Pay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addPaymentMethod,
          ),
        ],
      ),
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage Your Payment Methods',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  final paymentMethod = _paymentMethods[index];
                  return _buildPaymentMethodItem(index, paymentMethod['type']!, paymentMethod['details']!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(int index, String type, String details) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          type == 'Card' ? Icons.credit_card : type == 'PayPal' ? Icons.paypal : Icons.payment,
          color: Colors.blueAccent,
          size: 36,
        ),
        title: Text(
          type,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        subtitle: Text(
          details,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => _removePaymentMethod(index),
        ),
      ),
    );
  }
}
