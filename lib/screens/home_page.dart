import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/homescreen.dart';
import 'package:login_signup/screens/categories.dart';
import 'package:login_signup/screens/profile.dart';
import 'package:login_signup/screens/reservation.dart';
import 'package:login_signup/screens/search.dart'; 
import 'package:login_signup/screens/payment.dart';
import 'package:login_signup/screens/signin_screen.dart';
import 'package:login_signup/screens/view_reservations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(), // Room selection screen
    CombinedReservationScreen(userId: '',),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 243),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color.fromARGB(188, 250, 155, 217),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(188, 250, 155, 217),
              ),
              child: Text('Alztec'),
            ),
            ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            ListTile(
              title: const Text("Categories"),
              leading: const Icon(Icons.category),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoriesPage()));
              },
            ),
            ListTile(
              title: const Text("Reservations"),
              leading: const Icon(Icons.hotel),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            ListTile(
              title: const Text("Payment Methods"),
              leading: const Icon(Icons.credit_card),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentMethodsScreen()),
                );
              },
            ),
           ListTile(
  title: const Text("Log out"),
  leading: const Icon(Icons.logout),
  onTap: () async {
    await FirebaseAuth.instance.signOut(); // Firebase sign out

    // Clear saved login details from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');

    // Navigate back to the SignInScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (Route<dynamic> route) => false, // Remove all routes from the stack
    );
  },
),

          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bed), label: 'Reservations'),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
