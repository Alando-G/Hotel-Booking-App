import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum RoomCategory {
  SINGLE,
  DOUBLE,
  DELUXE,
  SUITE,
}

class ReservationScreen extends StatefulWidget {
  final double price;
  final RoomCategory roomCategory;
  final String userId;

  const ReservationScreen({super.key, required this.price, required this.roomCategory, required this.userId, required String hotelName, required List roomCategories});

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  DateTime _checkInDate = DateTime.now();
  DateTime _checkOutDate = DateTime.now().add(const Duration(days: 1));

  double get _totalPrice {
    int numberOfNights = _checkOutDate.difference(_checkInDate).inDays;
    return numberOfNights * widget.price;
  }

  Future<void> _submitReservation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Store the reservation in Firestore
      await FirebaseFirestore.instance.collection('reservations').add({
        'userId': widget.userId,
        'name': _name,
        'email': _email,
        'phoneNumber': _phoneNumber,
        'checkInDate': _checkInDate,
        'checkOutDate': _checkOutDate,
        'roomCategory': widget.roomCategory.toString(),
        'totalPrice': _totalPrice,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservation successful!')),
      );

      // Navigate back to CombinedReservationScreen
      Navigator.pop(context, true); // Pass a value to indicate that a reservation was made
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Make a Reservation',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField('Name', onSaved: (value) => _name = value!),
                const SizedBox(height: 20),
                _buildTextField('Email', onSaved: (value) => _email = value!),
                const SizedBox(height: 20),
                _buildTextField('Phone Number', onSaved: (value) => _phoneNumber = value!),
                const SizedBox(height: 30),
                _buildDateSelector('Check-in Date', _checkInDate, (newDate) {
                  setState(() {
                    _checkInDate = newDate;
                    if (_checkOutDate.isBefore(_checkInDate)) {
                      _checkOutDate = _checkInDate.add(const Duration(days: 1));
                    }
                  });
                }),
                const SizedBox(height: 20),
                _buildDateSelector('Check-out Date', _checkOutDate, (newDate) {
                  setState(() {
                    _checkOutDate = newDate;
                  });
                }, firstDate: _checkInDate.add(const Duration(days: 1))),
                const SizedBox(height: 40),
                Text(
                  'Total Price: \$${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitReservation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Confirm Reservation'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {required Function(String?) onSaved}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }

  Widget _buildDateSelector(String label, DateTime selectedDate, Function(DateTime) onDateSelected, {DateTime? firstDate}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 18),
        ),
        ElevatedButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: firstDate ?? DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
          child: Text(DateFormat.yMMMd().format(selectedDate)),
        ),
      ],
    );
  }
}
