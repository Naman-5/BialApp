import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:genie/home_page.dart';
import 'package:genie/flights_page.dart';
import 'package:genie/chat_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPage = 1;

  final _pages = [
    // TODO : Add pages for the options in bottom navigation bar
    const FlightsPage(),
    HomePage(),
  ];

  final _bottomIcons = [
    Icons.flight_rounded,
    Icons.home_filled,
    Icons.question_answer,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        color: Colors.grey.shade300,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.grey.shade300,
        height: 65,
        animationDuration: const Duration(milliseconds: 300),
        items: List.generate(3, (index) {
          return Icon(
            _bottomIcons[index],
            size: 30,
            color: Colors.grey,
          );
        }),
        onTap: (index) => {
          if (index == 2)
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage()))
            }
          else
            {
              setState(() {
                _currentPage = index;
              })
            }
        },
      ),
    );
  }
}
