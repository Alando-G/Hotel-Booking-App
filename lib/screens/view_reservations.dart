import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_signup/screens/reservation.dart';

class CombinedReservationScreen extends StatefulWidget {
  final String userId; 

  CombinedReservationScreen({required this.userId});

  @override
  _CombinedReservationScreenState createState() => _CombinedReservationScreenState();
}

class _CombinedReservationScreenState extends State<CombinedReservationScreen> {
  bool _showDetails = false;
  DocumentSnapshot? _selectedReservation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showDetails
          ? _buildReservationDetails()
          : _buildReservationList(),
    );
  }

  Widget _buildReservationList() {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('reservations')
          .where('userId', isEqualTo: widget.userId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Reservations Found',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationScreen(
                          price: 0, // Default price logic
                          roomCategory: RoomCategory.SINGLE, userId: '', roomCategories: [], hotelName: '', // Default selection
                        ),
                      ),
                    );
                  },
                  child: Text('Make a Reservation'),
                ),
              ],
            ),
          );
        }

        final reservations = snapshot.data!.docs;

        return ListView.builder(
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final reservation = reservations[index];

            return ListTile(
              leading: Icon(Icons.hotel, color: Colors.blue),
              title: Text(reservation['name']),
              subtitle: Text('Check-in: ${DateFormat.yMMMd().format(reservation['checkInDate'].toDate())}'),
              trailing: Text('\$${reservation['totalPrice']}'),
              onTap: () {
                setState(() {
                  _selectedReservation = reservation;
                  _showDetails = true;
                });
              },
            );
          },
        );
      },
    );
  }

  Widget _buildReservationDetails() {
    if (_selectedReservation == null) {
      return Center(child: Text('No reservation selected'));
    }

    final reservation = _selectedReservation!;
    final roomCategory = reservation['roomCategory'].toString().split('.').last;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.receipt_long, size: 80, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Reservation Details',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildDetailRow(Icons.person, 'Name', reservation['name']),
            _buildDetailRow(Icons.email, 'Email', reservation['email']),
            _buildDetailRow(Icons.phone, 'Phone Number', reservation['phoneNumber']),
            _buildDetailRow(Icons.calendar_today, 'Check-in Date',
                DateFormat.yMMMd().format(reservation['checkInDate'].toDate())),
            _buildDetailRow(Icons.calendar_today_outlined, 'Check-out Date',
                DateFormat.yMMMd().format(reservation['checkOutDate'].toDate())),
            _buildDetailRow(Icons.king_bed, 'Room Category', roomCategory),
            _buildDetailRow(Icons.attach_money, 'Total Price', '\$${reservation['totalPrice']}'),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showDetails = false;
                    _selectedReservation = null;
                  });
                },
                child: Text('Back to List'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              '$label: $value',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
