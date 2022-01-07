import 'package:flutter/material.dart';
import 'package:genie/bottom_nav.dart';
import 'package:genie/home_page.dart';
import 'package:genie/flights_page.dart';
import 'package:genie/chat_page.dart';
import 'package:genie/retail/shopspreview/homepage.dart';
// import 'package:genie/retail/shopslistpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPage = 0;

  final List<BarItem> _barItems = [
    BarItem(
        label: 'Home',
        iconData: Icons.home_outlined,
        color: Colors.indigo,
        page: HomePage()),
    BarItem(
        label: 'Flights',
        iconData: Icons.flight_rounded,
        color: Colors.pinkAccent,
        page: const FlightsPage()),
    BarItem(
        label: 'Shop',
        iconData: Icons.shopping_bag_outlined,
        color: Colors.yellow.shade800,
        page: RetailHomePage()),
    BarItem(
        label: 'ChatBot',
        iconData: Icons.question_answer_outlined,
        color: Colors.cyan,
        navigateToPage: false,
        page: const ChatPage())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _barItems[_currentPage].page,
      bottomNavigationBar: CustomBottomNavBar(
        barItems: _barItems,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
