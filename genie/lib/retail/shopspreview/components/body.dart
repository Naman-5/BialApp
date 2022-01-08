import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genie/retail/shopitems/shopitems.dart';


class ShopsGridView extends StatefulWidget {

  final List shopps;
  // required this.shopps
  const ShopsGridView({ Key? key, required this.shopps }) : super(key: key);

  @override
  _ShopsGridViewState createState() => _ShopsGridViewState();
}

class _ShopsGridViewState extends State<ShopsGridView> {

  @override
  Widget build(BuildContext context) {

    //  var sh = json.decode(widget.shopps);
    //  print(widget.shopps);

    // final List shopps;
    // List shopss = ShopDetails.shops;
    // print(widget.shopps[0]['location']);
    // Map<String, dynamic> encshopss = ShopDetails.shops;
    // print(widget.shopps[0]);

    return 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: (){
              // Navigator.pushNamed(context, "/shopitems",
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=> ShopItems(shops: widget.shopps,) )
              );
            },
            child: Container(
                // padding: EdgeInsets.all(20.0),
                height: 180,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    // image: AssetImage('assets/images/JackandJones.png')),
                    image: NetworkImage("${widget.shopps[0]["image"]}")),
                  ),
                // child: Image.asset('assets/images/JackandJones.png'),
            ),
          ),
          Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
          // child: Text(sh["id"]),
          child: Text(widget.shopps[0]["id"], 
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),),
        )
        // Text("Jack and Jones"),
      ],
    );
  }
}