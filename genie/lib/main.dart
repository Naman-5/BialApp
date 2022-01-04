import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'feedback.dart';
import 'helper/check_signin.dart';
import 'helper/get_airline_contacts.dart';

void main() async {
  await AirlineResourceRequest.getContacts();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
