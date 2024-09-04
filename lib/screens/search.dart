import 'package:flutter/material.dart';
import 'package:login_signup/screens/reservation.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search for Rooms",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildRoomCard(
              context,
              'Single Room',
              'A cozy room ideal for solo travelers.',
              50.0,
              'assets/images/single.jpg', // Add a relevant image asset
              RoomCategory.SINGLE,
            ),
            _buildRoomCard(
              context,
              'Double Room',
              'A spacious room perfect for couples or friends.',
              80.0,
              'assets/images/double_room.jpg', // Add a relevant image asset
              RoomCategory.DOUBLE,
            ),
            _buildRoomCard(
              context,
              'Suite',
              'An elegant suite with luxurious amenities.',
              150.0,
              'assets/images/suite.jpg', // Add a relevant image asset
              RoomCategory.SUITE,
            ),
            _buildRoomCard(
              context,
              'Deluxe Room',
              'An opulent room with premium features.',
              200.0,
              'assets/images/delux_room.jpg',
              RoomCategory.DELUXE,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(
      BuildContext context,
      String title,
      String description,
      double price,
      String imagePath,
      RoomCategory roomCategory) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReservationScreen(
                roomCategory: roomCategory,
                price: price,
                userId: '', hotelName: '', roomCategories: const [], 
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                imagePath,
                height: 180.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$price/night',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.blue.shade700),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
