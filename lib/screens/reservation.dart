import 'package:flutter/material.dart';
import 'package:login_signup/screens/categories.dart';


enum RoomCategory{
  SINGLE,
  DOUBLE,
  DELUXE,
  SUITE,
}
class ReservationScreen extends StatefulWidget {
  
final double price;
  final RoomCategory;
  ReservationScreen({required this.price, required this.RoomCategory, required category});



  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  DateTime _checkInDate = DateTime.now();
  DateTime _checkOutDate = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make a Reservation'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value!,
              ),
              Row(
                children: [
                  Text('Check-in Date: '),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _checkInDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _checkInDate = picked;
                        });
                      }
                    },
                    child: Text(_checkInDate.toString().split(' ').first),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Check-out Date: '),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _checkOutDate,
                        firstDate: _checkInDate.add(Duration(days: 1)),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _checkOutDate = picked;
                        });
                      }
                    },
                    child: Text(_checkOutDate.toString().split(' ').first),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Make API call or database query to save the reservation
                    // For demonstration purposes, just print the reservation details
                    print('Reservation made for:');
                    print('Name: $_name');
                    print('Email: $_email');
                    print('Phone Number: $_phoneNumber');
                    print('Check-in Date: ${_checkInDate.toString().split(' ').first}');
                    print('Check-out Date: ${_checkOutDate.toString().split(' ').first}');
                    print('Price: \$${widget.price.toString()}');
                    Navigator.pop(context);
                  }
                },
                child: Text('Make Reservation'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
