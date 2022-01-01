import 'dart:developer';

import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'sign_up.dart';
import 'helper/get_airline_contacts.dart';

void main() async {
  await AirlineResourceRequest.getContacts();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
