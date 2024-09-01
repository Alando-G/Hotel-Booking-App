import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment_methods_provider.dart';

class CardDetailsScreen extends StatefulWidget {
  final String methodType;

  CardDetailsScreen({required this.methodType});

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
        title: Text('Enter ${widget.methodType} Details', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _cardHolderController,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _expiryDateController,
                      decoration: InputDecoration(
                        labelText: 'Expiry Date (MM/YY)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _cvvController,
                      decoration: InputDecoration(
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
                decoration: InputDecoration(
                  labelText: 'PayPal Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ] else if (widget.methodType == 'Google Pay') ...[
              TextField(
                controller: _googlePayNumberController,
                decoration: InputDecoration(
                  labelText: 'Google Pay Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
            SizedBox(height: 24),
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
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _saveCardDetails,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
