import 'package:flutter/material.dart';
import 'package:login_signup/screens/search.dart';

class HotelDetailsScreen extends StatelessWidget {
  final String hotelName;
  final String imagePath;

  const HotelDetailsScreen({super.key, required this.hotelName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotelName),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Hotel Name
            Text(
              hotelName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Hotel Description
            const Text(
              'This luxurious hotel offers unparalleled comfort and style. Located in the heart of the city, it\'s the perfect destination for both business and leisure travelers.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            // Amenities Section
            const Text(
              'Amenities',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.wifi, color: Colors.black, size: 30),
                Icon(Icons.pool, color: Color.fromARGB(255, 0, 0, 0), size: 30),
                Icon(Icons.spa, color: Color.fromARGB(255, 0, 0, 0), size: 30),
                Icon(Icons.local_dining, color: Color.fromARGB(255, 0, 0, 0), size: 30),
              ],
            ),
            const SizedBox(height: 20),
            // Reviews Section
            const Text(
              'Customer Reviews',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildReview('John Doe', 'Absolutely amazing stay! The service was top-notch, and the rooms were spacious.'),
            _buildReview('Jane Smith', 'Great location, friendly staff, and excellent amenities. Highly recommended!'),
            const SizedBox(height: 40),
            // Book Now Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build customer review widget
  Widget _buildReview(String reviewer, String review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 31, 32, 32),
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reviewer,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(review, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
