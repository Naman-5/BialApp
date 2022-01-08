import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(49, 153, 218, 1),
        image: DecorationImage(image: AssetImage("assets/images/flightloading.gif"))
      ),
    );
  }
}