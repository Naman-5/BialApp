import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:genie/home_page.dart';
import 'package:genie/flights_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPage = 0;

  final _pages = [
    // TODO : Add pages for the options in bottom navigation bar
    HomePage(),
    const FlightsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Colors.grey.shade300,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        buttonBackgroundColor: Colors.grey.shade300,
        height: 65,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.home_filled,
            size: 27,
            color: Colors.grey,
          ),
          Icon(
            Icons.flight_rounded,
            size: 27,
            color: Colors.grey,
          ),
          Icon(Icons.shopping_cart_rounded, size: 27, color: Colors.grey),
          Icon(Icons.restaurant, color: Colors.grey, size: 27),
        ],
        onTap: (index) => {
          setState(() {
            _currentPage = index;
          })
        },
      ),
    );
  }
}
