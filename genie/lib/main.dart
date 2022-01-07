import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'helper/get_airline_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:genie/helper/shops.dart';

void main() async {
  await ShopDetails.getShops();
  await Hive.initFlutter();
  await Hive.openBox('cartBox');
  Box cart = Hive.box('cartBox');
  if(cart.isEmpty) cart.put('items', []);

  await AirlineResourceRequest.getContacts();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
