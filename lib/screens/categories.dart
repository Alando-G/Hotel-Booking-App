// ignore_for_file: prefer_const_constructors, constant_identifier_names, library_private_types_in_public_api, prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, unnecessary_string_interpolations, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:login_signup/screens/reservation.dart';
import 'package:login_signup/screens/room_category.dart'as category;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Room Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
      ),
      home: CategoriesPage(),
    );
  }
}

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<RoomCategory> _categories = [
    RoomCategory.SINGLE,
    RoomCategory.DOUBLE,
    RoomCategory.SUITE,
    RoomCategory.DELUXE,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Categories'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomDetailsPage(
                      category: category,
                      description: getDescription(category),
                      price: getPrice(category),
                      images: getCategoryImages(category),
                      amenities: getAmenities(category),
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Background image for the category
                    Image.asset(
                      getCategoryImage(category),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Inverted rectangle overlay with details
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  category.toString().split('.').last,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '\$${getPrice(category).toString()}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String getCategoryImage(RoomCategory category) {
    switch (category) {
      case RoomCategory.SINGLE:
        return 'assets/images/room1.jpg';
      case RoomCategory.DOUBLE:
        return 'assets/images/double_room.jpg';
      case RoomCategory.SUITE:
        return 'assets/images/suite.jpg';
      case RoomCategory.DELUXE:
        return 'assets/images/delux_room.jpg';
      default:
        return '';
    }
  }

  List<String> getCategoryImages(RoomCategory category) {
    switch (category) {
      case RoomCategory.SINGLE:
        return [
          'assets/images/room1.jpg',
          'assets/images/single_room_1.jpg',
          'assets/images/single_room_2.jpg'
        ];
      case RoomCategory.DOUBLE:
        return [
          'assets/images/double_room.jpg',
          'assets/images/double_room_1.jpg',
          'assets/images/double_room_2.jpg'
        ];
      case RoomCategory.SUITE:
        return [
          'assets/images/suit_room.jpg',
          'assets/images/suite_room_1.jpg',
          'assets/images/suite_room_2.jpg'
        ];
      case RoomCategory.DELUXE:
        return [
          'assets/images/delux_room.jpg',
          'assets/images/deluxe_room_1.jpg',
          'assets/images/deluxe_room_2.jpg'
        ];
      default:
        return [];
    }
  }

  String getDescription(RoomCategory category) {
    switch (category) {
      case RoomCategory.SINGLE:
        return 'Single Room with one bed';
      case RoomCategory.DOUBLE:
        return 'Double Room with two beds';
      case RoomCategory.SUITE:
        return 'Suite Room with living area and kitchen';
      case RoomCategory.DELUXE:
        return 'Deluxe Room with luxurious amenities';
      default:
        return '';
    }
  }

  double getPrice(RoomCategory category) {
    switch (category) {
      case RoomCategory.SINGLE:
        return 50.0;
      case RoomCategory.DOUBLE:
        return 80.0;
      case RoomCategory.SUITE:
        return 150.0;
      case RoomCategory.DELUXE:
        return 200.0;
      default:
        return 0.0;
    }
  }

  List<String> getAmenities(RoomCategory category) {
    switch (category) {
      case RoomCategory.SINGLE:
        return ['Free Wi-Fi', 'Air Conditioning', 'Breakfast Included'];
      case RoomCategory.DOUBLE:
        return [
          'Free Wi-Fi',
          'Air Conditioning',
          'Breakfast Included',
          'Balcony'
        ];
      case RoomCategory.SUITE:
        return [
          'Free Wi-Fi',
          'Air Conditioning',
          'Breakfast Included',
          'Living Area',
          'Kitchen'
        ];
      case RoomCategory.DELUXE:
        return [
          'Free Wi-Fi',
          'Air Conditioning',
          'Breakfast Included',
          'Balcony',
          'Jacuzzi'
        ];
      default:
        return [];
    }
  }
}

class RoomDetailsPage extends StatelessWidget {
  final RoomCategory category;
  final String description;
  final double price;
  final List<String> images;
  final List<String> amenities;

  RoomDetailsPage({
    required this.category,
    required this.description,
    required this.price,
    required this.images,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.toString().split('.').last} Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                '${category.toString().split('.').last}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Price: \$${price.toString()}',
                style: TextStyle(fontSize: 18, color: Colors.orange),
              ),
              SizedBox(height: 20),
              Text(
                'Amenities',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: amenities.map((amenity) {
                  return Chip(
                    label: Text(amenity),
                    backgroundColor: Colors.blue.shade100,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to ReservationScreen with selected room's price and category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationScreen(
                        price: price,
                        roomCategory: category, roomCategories: const [], userId: '', hotelName: '',
                      ),
                    ),
                  );
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
