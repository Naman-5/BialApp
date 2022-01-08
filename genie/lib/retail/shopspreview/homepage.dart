// import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genie/retail/shopspreview/components/body.dart';
import 'package:genie/retail/shopspreview/components/header.dart';
import 'package:genie/helper/shops.dart';


class RetailHomePage extends StatefulWidget {
  const RetailHomePage({ Key? key }) : super(key: key);

  @override
  _RetailHomePageState createState() => _RetailHomePageState();
}

class _RetailHomePageState extends State<RetailHomePage> {
  @override
  Widget build(BuildContext context) {

    var shopss = ShopDetails.shops;
    // print(shopss[0]["location"]);
    // var sh = json.decode(shopss[0]);
    // print(sh["location"]);
    int ListLength = shopss.length;
    // print(ListLength);
    // print(shopss[0]['location']);

    return Scaffold(
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShopHeader(),
              // SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Stores", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.builder(
                    itemCount: ListLength,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.75,
                    ), 
                    // shopps: shopss[index],
                    itemBuilder: (context, index) => ShopsGridView(shopps: [shopss[index]],)),
                ),
              ),),
                ],
        ),
    );
  }
}