import 'package:flutter/material.dart';
import 'package:login_signup/screens/search.dart';

class SearchBottomNavigationBarScreen extends StatefulWidget {
  const SearchBottomNavigationBarScreen({super.key});

  @override
  _SearchBottomNavigationBarScreenState createState() => _SearchBottomNavigationBarScreenState();
}

class _SearchBottomNavigationBarScreenState extends State<SearchBottomNavigationBarScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          // Add more items as needed
        ],
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return const SearchScreen(); // Replace with your search screen
      // Add more cases as needed
      default:
        return const Center(child: Text('No screen for this index'));
    }
  }
}