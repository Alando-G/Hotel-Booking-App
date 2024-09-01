import 'package:flutter/material.dart';
import 'package:login_signup/screens/card_details.dart';
import 'package:provider/provider.dart';
import 'payment_methods_provider.dart';

class PaymentMethodsScreen extends StatelessWidget {
  void _addPaymentMethod(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildPaymentMethodSelector(context),
    );
  }

  void _onPaymentMethodSelected(BuildContext context, String methodType) {
    Navigator.of(context).pop(); // Close the bottom sheet
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CardDetailsScreen(methodType: methodType),
      ),
    );
  }

  Widget _buildPaymentMethodSelector(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.blueAccent),
            title: Text('Credit/Debit Card'),
            onTap: () => _onPaymentMethodSelected(context, 'Card'),
          ),
          ListTile(
            leading: Icon(Icons.paypal, color: Colors.blueAccent),
            title: Text('PayPal'),
            onTap: () => _onPaymentMethodSelected(context, 'PayPal'),
          ),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.blueAccent),
            title: Text('Google Pay'),
            onTap: () => _onPaymentMethodSelected(context, 'Google Pay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Consumer<PaymentMethodsProvider>(
        builder: (context, provider, child) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Methods',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.paymentMethods.length,
                  itemBuilder: (context, index) {
                    return _buildPaymentMethodItem(context, index);
                  },
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () => _addPaymentMethod(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    elevation: 8,
                  ),
                  child: Text('Add Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(BuildContext context, int index) {
    final provider = Provider.of<PaymentMethodsProvider>(context);
    final paymentMethod = provider.paymentMethods[index];
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(Icons.credit_card, color: Colors.blueAccent, size: 36),
        title: Text(
          paymentMethod['type']!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        subtitle: Text(
          paymentMethod['number']!,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => provider.removePaymentMethod(index),
        ),
      ),
    );
  }
}
