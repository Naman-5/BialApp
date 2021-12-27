import 'package:flutter/material.dart';
import 'package:genie/retail/components/header.dart';
import 'package:genie/retail/components/shopsbody.dart';

class RetailHomePage extends StatefulWidget {
  const RetailHomePage({Key? key}) : super(key: key);

  @override
  _RetailHomePageState createState() => _RetailHomePageState();
}

class _RetailHomePageState extends State<RetailHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShopHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ShopsGridView()),
          ),
        ),
      ],
    );
  }
}
