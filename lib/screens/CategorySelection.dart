// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:login_signup/screens/Homescreen.dart';
import 'package:login_signup/screens/categories.dart';
import 'package:login_signup/screens/home_page.dart';
import 'package:login_signup/screens/profile.dart';
import 'package:login_signup/screens/search.dart';

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    CategorySelectionScreen(), // New screen for category selection
    SearchScreen(),
    ProfileScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  // ...
}

class CategorySelectionScreen extends StatefulWidget {
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
        title: Text("Select Room Category"),
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
            items: [
              DropdownMenuItem(
                child: Text("Category 1"),
                value: RoomCategory.SINGLE,
              ),
              DropdownMenuItem(
                child: Text("Category 2"),
                value: RoomCategory.DOUBLE,
              ),
               DropdownMenuItem(
                child: Text("Category 2"),
                value: RoomCategory.DELUXE,
              ),
               DropdownMenuItem(
                child: Text("Category 2"),
                value: RoomCategory.SUITE,
              ),
              // Add more categories as needed
            ],
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Price",
            ),
            onChanged: (value) {
              setState(() {
                _price = double.parse(value);
              });
            },
          ),
          ElevatedButton(
            child: Text("Next"),
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