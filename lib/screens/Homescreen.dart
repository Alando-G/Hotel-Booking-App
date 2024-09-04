import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/destination_details_screen.dart';
import 'package:login_signup/screens/hotel_details.dart';
import 'package:login_signup/screens/offers_screen.dart';
import 'package:login_signup/screens/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _autoScrollFeaturedHotels();
  }

  void _autoScrollFeaturedHotels() {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          height: 240, // Adjust as needed
          child: PageView(
            controller: _pageController,
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
        width: 180,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
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
        _buildOfferCard(
            context,
            'Get 20% off on your first booking',
            'Use code: FIRST20',
            Icons.local_offer,
            Colors.red),
        _buildOfferCard(
            context,
            'Weekend Getaway: 15% off',
            'Book by this weekend',
            Icons.beach_access,
            Colors.blue),
      ],
    );
  }

  Widget _buildOfferCard(
      BuildContext context, String title, String subtitle, IconData icon, Color iconColor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  OffersScreen(),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            final destinations = [
              {'city': 'Paris', 'image': 'assets/images/paris.jpg'},
              {'city': 'New York', 'image': 'assets/images/newyork.jpg'},
              {'city': 'Tokyo', 'image': 'assets/images/tokyo.jpg'},
              {'city': 'London', 'image': 'assets/images/london.jpg'},
            ];
            return _buildDestinationCard(
                context, destinations[index]['city']!, destinations[index]['image']!);
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 200,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    city,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialOffersScreen {
  const SpecialOffersScreen();
}
