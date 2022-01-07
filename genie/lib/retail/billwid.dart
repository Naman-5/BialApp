import 'dart:convert';

import 'package:flutter/material.dart';


class ShowTotBill extends StatefulWidget {
  final int totbagcost;
  const ShowTotBill({ Key? key, required this.totbagcost }) : super(key: key);

  @override
  _ShowTotBillState createState() => _ShowTotBillState();
}

class _ShowTotBillState extends State<ShowTotBill> {

  // bool value = false;
  bool? val = false;

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      // Checkbox(value: true, onChanged: (value) => {}),

      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Redeem Reward Points"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Checkbox(value: val, onChanged: (value) {
              setState(() {
                this.val = value;
                // print(value);
              });
            }),
          ),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Bag Total"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('\u{20B9} ${widget.totbagcost}'),
          ),
        ],
      ),

      if(val==true) Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Rewards"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('\u{20B9} 100'),
          ),
        ],
      ),


      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Total Amount"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('\u{20B9} 6900'),
          ),
        ],
      )
    ],
  );
  }
}