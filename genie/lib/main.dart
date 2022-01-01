import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'sign_up.dart';
import 'helper/get_airline_contacts.dart';
import 'helper/flight_info.dart';

void main() async {
  AirlineResourceRequest.getContacts();
  await FlightDetails.getFlights();
  print(FlightDetails.flights);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
