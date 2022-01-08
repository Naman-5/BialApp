import 'dart:convert';
import 'package:genie/retail/shopspreview/homepage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ShowTotBill extends StatefulWidget {
  final int totbagcost;
  final List orderlist;
  final List myorderslist;
  const ShowTotBill({ Key? key, required this.totbagcost, required this.orderlist, required this.myorderslist }) : super(key: key);

  @override
  _ShowTotBillState createState() => _ShowTotBillState();
}

class _ShowTotBillState extends State<ShowTotBill> {

  bool redeemtrue = false;

  @override
  Widget build(BuildContext context) {
    var rewards;
    if(rewards==null){
      rewards = 0;
    }
    // print(widget.totbagcost);
    int redeem;
      if(redeemtrue){
        redeem = 1;
      }else{
        redeem=0;
      }
    
    // print(widget.orderlist);
    // print("/n");
    // print(widget.myorderslist);

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
         Switch(
            value: redeemtrue,
            onChanged: (bool value) {
            // print("The value: $value");
            setState(() {
              redeemtrue = value;
            });
            },
         ),


          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Checkbox(value: val, onChanged: (value) {
          //     setState(() {
          //       val = value;
          //       // print(value);
          //     });
          //   }),
          // ),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Total Amout"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            // child: Text('\u{20B9} ${widget.totbagcost}'),
            child: Text('\u{20B9} ${widget.totbagcost}'),
          ),
        ],
      ),

      // if(redeemtrue==true) Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Text("Rewards"),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Text('\u{20B9} ${rewards}'),
      //     ),
      //   ],
      // ),


      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Text("Total Amount"),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: Text('\u{20B9} 6900'),
      //     ),
      //   ],
      // ),
      SizedBox(height: 10,),
      MaterialButton(
        onPressed: () async {
          
          const storage = FlutterSecureStorage();
          var url = Uri.parse(
                      'https://bialapp.azurewebsites.net/api/checkout?code=JijJ4KYjR6ZB5AvV7mvtaR7e0D4HLvJT1rSjyoBplhrHno8AKEPo5A%3D%3D');
                  try {
                    var response = await http.post(url,
                        body: json.encode({
                            'token': await storage.read(key: "signInToken"),
                            'products': widget.orderlist,
                            'redeem': redeem.toString(),
                        }));
                    var mess = json.decode(response.body);
                    // rewards = mess["message"]["rewards"];
                    print("response -> ${json.decode(response.body)}");
                    rewards = mess["message"]["rewards"];
                    print(rewards);
                    Box rewbox = Hive.box('rewards');
                    rewbox.put("currRew", rewards);
                    // setState(() {
                    //   rewards = mess["message"]["rewards"];
                    // });

                    Box ordboxx = Hive.box('myOrders');
                    List orderitems = ordboxx.get('items');
                    for(int i=0; i<widget.myorderslist.length; i++){
                      orderitems.add(widget.myorderslist[i]);
                    }
                    print(orderitems);
                    ordboxx.put('items', orderitems);
                    // print(orderitems);
                    if(mounted) setState(() {
                      Box boxx = Hive.box('cartBox');
                      boxx.put('items', []);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RetailHomePage()));
                  } on Exception {
                    print('failed');
                  }


        },
        // child: Text("Place Order"),
         color: Colors.cyan,
                    // minWidth: double.infinity,
                    minWidth: 150,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Text("Place Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    ),
      )
    ],
  );
  }
}