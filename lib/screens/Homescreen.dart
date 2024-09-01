import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        _buildFeaturedHotels(context),
        SizedBox(height: 20),
        _buildSpecialOffers(context),
        SizedBox(height: 20),
        _buildPopularDestinations(context),
      ],
    );
  }

  Widget _buildFeaturedHotels(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Featured Hotels',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 10),
        Container(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildHotelCard(context, 'Hotel Sunshine',
                  'assets/images/hotel1.jpg', '/hotelDetails'),
              _buildHotelCard(context, 'Hotel Comfort',
                  'assets/images/hotel2.jpg', '/hotelDetails'),
              _buildHotelCard(context, 'Hotel Luxury',
                  'assets/images/hotel3.jpg', '/hotelDetails'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHotelCard(
      BuildContext context, String name, String imagePath, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: {'hotelName': name});
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        Text(
          'Special Offers',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 10),
        _buildOfferCard(context, 'Get 20% off on your first booking',
            'Use code: FIRST20', Icons.local_offer, Colors.red, '/offers'),
        _buildOfferCard(context, 'Weekend Getaway: 15% off',
            'Book by this weekend', Icons.beach_access, Colors.blue, '/offers'),
      ],
    );
  }

  Widget _buildOfferCard(BuildContext context, String title, String subtitle,
      IconData icon, Color iconColor, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: {'offerTitle': title});
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Icon(icon, size: 40, color: iconColor),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  Widget _buildPopularDestinations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Popular Destinations',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            return _buildDestinationCard(context, destinations[index]['city']!,
                destinations[index]['image']!, '/destinationDetails');
          },
        ),
      ],
    );
  }

  Widget _buildDestinationCard(
      BuildContext context, String city, String imagePath, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route,
            arguments: {'destinationCity': city});
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
