import 'package:flutter/material.dart';
import 'package:login_signup/screens/destination_details_screen.dart';
import 'package:login_signup/screens/hotel_details.dart'; // Import the hotel details screen
import 'package:login_signup/screens/destination_details_screen.dart'; // Import the destination details screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        _buildFeaturedHotels(context),
        const SizedBox(height: 20),
        _buildSpecialOffers(context),
        const SizedBox(height: 20),
        _buildPopularDestinations(context),
      ],
    );
  }

  Widget _buildFeaturedHotels(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Featured Hotels',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildHotelCard(context, 'Hotel Sunshine', 'assets/images/hotel1.jpg'),
              _buildHotelCard(context, 'Hotel Comfort', 'assets/images/hotel2.jpg'),
              _buildHotelCard(context, 'Hotel Luxury', 'assets/images/hotel3.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHotelCard(BuildContext context, String name, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailsScreen(hotelName: name, imagePath: imagePath),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 160,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialOffers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Special Offers',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        _buildOfferCard(context, 'Get 20% off on your first booking', 'Use code: FIRST20', Icons.local_offer, Colors.red),
        _buildOfferCard(context, 'Weekend Getaway: 15% off', 'Book by this weekend', Icons.beach_access, Colors.blue),
      ],
    );
  }

  Widget _buildOfferCard(BuildContext context, String title, String subtitle, IconData icon, Color iconColor) {
    return GestureDetector(
      onTap: () {
        // Navigate to offers page
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Icon(icon, size: 40, color: iconColor),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          contentPadding: const EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  Widget _buildPopularDestinations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Popular Destinations',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.5,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final destinations = [
              {'city': 'Paris', 'image': 'assets/images/paris.jpg'},
              {'city': 'New York', 'image': 'assets/images/newyork.jpg'},
              {'city': 'Tokyo', 'image': 'assets/images/tokyo.jpg'},
              {'city': 'London', 'image': 'assets/images/london.jpg'},
            ];
            return _buildDestinationCard(context, destinations[index]['city']!, destinations[index]['image']!);
          },
        ),
      ],
    );
  }

  Widget _buildDestinationCard(BuildContext context, String city, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailsScreen(destinationCity: city, imagePath: imagePath),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                city,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
