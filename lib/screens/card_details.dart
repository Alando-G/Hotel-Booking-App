import 'package:flutter/material.dart';

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
    // Simulate saving details and navigate back
    Navigator.of(context).pop(); 
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter ${widget.methodType} Details', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: const Color.fromARGB(255, 67, 67, 67),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.methodType == 'Card') ...[
              _buildTextField(_cardNumberController, 'Card Number', TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField(_cardHolderController, 'Card Holder Name', TextInputType.text),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField(_expiryDateController, 'Expiry Date (MM/YY)', TextInputType.datetime)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_cvvController, 'CVV', TextInputType.number)),
                ],
              ),
            ] else if (widget.methodType == 'PayPal') ...[
              _buildTextField(_paypalEmailController, 'PayPal Email', TextInputType.emailAddress),
            ] else if (widget.methodType == 'Google Pay') ...[
              _buildTextField(_googlePayNumberController, 'Google Pay Number', TextInputType.number),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: _saveCardDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 6, 6, 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputType keyboardType) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
      ),
      keyboardType: keyboardType,
    );
  }
}
