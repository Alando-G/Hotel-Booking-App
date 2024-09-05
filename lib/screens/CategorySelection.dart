// ignore_for_file: unused_element, unused_field, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:login_signup/screens/Homescreen.dart';
import 'package:login_signup/screens/home_page.dart';
import 'package:login_signup/screens/profile.dart';
import 'package:login_signup/screens/room_category.dart';
import 'package:login_signup/screens/search.dart';


class _HomeState extends State<Home> {
  final int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const CategorySelectionScreen(), // New screen for category selection
    const SearchScreen(),
    const ProfileScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    
    throw UnimplementedError();
  }

  // ...
}

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  _CategorySelectionScreenState createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  RoomCategory _selectedCategory = RoomCategory.SINGLE; // Initialize with a default value
  double _price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Room Category"),
      ),
      body: Column(
        children: [
          DropdownButton<RoomCategory>(
            value: _selectedCategory,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            items: const [
              DropdownMenuItem(
                value: RoomCategory.SINGLE,
                child: Text("Category 1"),
              ),
              DropdownMenuItem(
                value: RoomCategory.DOUBLE,
                child: Text("Category 2"),
              ),
               DropdownMenuItem(
                value: RoomCategory.DELUXE,
                child: Text("Category 2"),
              ),
               DropdownMenuItem(
                value: RoomCategory.SUITE,
                child: Text("Category 2"),
              ),
              // Add more categories as needed
            ],
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Price",
            ),
            onChanged: (value) {
              setState(() {
                _price = double.parse(value);
              });
            },
          ),
          ElevatedButton(
            child: const Text("Next"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>(
                    RoomDetails(_selectedCategory, _price)
                    
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

RoomDetails(RoomCategory selectedCategory, double price) {
}