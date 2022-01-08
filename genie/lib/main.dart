import 'package:flutter/material.dart';
import 'package:genie/splashscreen.dart';
import 'home_screen.dart';
import 'helper/get_airline_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:genie/helper/shops.dart';

void main() async {
  runApp(const SplashScreen());
  await ShopDetails.getShops();
  await Hive.initFlutter();
  // Hive.deleteBoxFromDisk('myOrders');
  
  await Hive.openBox('cartBox');
  Box cart = Hive.box('cartBox');
  if(cart.isEmpty) cart.put('items', []);

  await Hive.openBox('myOrders');
  Box myorders = Hive.box('myOrders');
  if(myorders.isEmpty) myorders.put('items', []);

  await Hive.openBox("rewards");
  Box rew = Hive.box("rewards");
  if(rew.isEmpty) rew.put("currRew", 0);

  await AirlineResourceRequest.getContacts();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
