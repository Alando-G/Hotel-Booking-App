import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment_methods_provider.dart';

class CardDetailsScreen extends StatefulWidget {
  final String methodType;

  const CardDetailsScreen({super.key, required this.methodType});

  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _paypalEmailController = TextEditingController();
  final _googlePayNumberController = TextEditingController();

  void _saveCardDetails() {
    final provider = Provider.of<PaymentMethodsProvider>(context, listen: false);

    Map<String, String> paymentMethod = {
      'type': widget.methodType,
      'number': widget.methodType == 'Card' ? _cardNumberController.text : 
                widget.methodType == 'PayPal' ? _paypalEmailController.text : 
                _googlePayNumberController.text,
    };

    provider.addPaymentMethod(paymentMethod);
    Navigator.of(context).pop(); // Go back to the previous screen
  }

  void _cancel() {
    Navigator.of(context).pop(); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Enter ${widget.methodType} Details', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.methodType == 'Card') ...[
              TextField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cardHolderController,
                decoration: const InputDecoration(
                  labelText: 'Card Holder Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _expiryDateController,
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date (MM/YY)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ] else if (widget.methodType == 'PayPal') ...[
              TextField(
                controller: _paypalEmailController,
                decoration: const InputDecoration(
                  labelText: 'PayPal Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ] else if (widget.methodType == 'Google Pay') ...[
              TextField(
                controller: _googlePayNumberController,
                decoration: const InputDecoration(
                  labelText: 'Google Pay Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _cancel,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _saveCardDetails,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
