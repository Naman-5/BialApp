// import 'package:flutter/cupertino.dart';
// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genie/retail/billwid.dart';
import 'package:genie/retail/myorders.dart';
import 'package:genie/retail/productdetail.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  // var rewards;
  // List cartItems=[];
  // Box boxx = Hive.box('cartBox');
  //   CartPage(){
  //     cartItems = boxx.get('items');
  //   }

  @override
  Widget build(BuildContext context) {

    int lengthh;
    Box boxx = Hive.box('cartBox');
    // if(boxx.get("items"))  List cartItems = boxx.get('items'), lengthh = cartItems.length;
    List cartItems = boxx.get('items');
    // if (cartItems?.isEmpty ?? true) lengthh = 0;
    if (cartItems.isEmpty) lengthh = 0;
    else lengthh = cartItems.length;
    
    // var itemCost = itemCount*cartItems[index][2];
    int bagtotcost=0;
    int roundcost=0;
    // int redeem=0;

    // print(rewards);
    // print(cartItems[0]);
    // print(boxx);


    return Scaffold(
      appBar: AppBar(
                  backgroundColor: Colors.indigo[300],
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close,),),
                  title: Text("Cart Items", style: TextStyle(
                    // color: Colors.black,
                  ),),
                  // leading: BackButton(color: Colors.white,)
                ),
      body: Column(
              children:[
                Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: lengthh,
                    itemBuilder: (BuildContext context, index){
                      
                      // int itemCount = 1;
                      int itemCost = cartItems[index][4]*(int.parse(cartItems[index][2]));
                      bagtotcost = roundcost + itemCost;
                      roundcost = itemCost;
                      // print(bagtotcost);
      
                      return GestureDetector(
                        onTap: (){
                           Navigator.of(context).push(MaterialPageRoute(builder:(context)=> 
                              ProductDetailss(itemdet: cartItems[index][6], ind: cartItems[index][5], shopname: cartItems[index][0])
                           ));
                          // Navigator.pushNamed(context, ProductDetailss(itemdet: [], ind: cartItems[index][5], shopname: cartItems[index][0]))
                        },
                        child: Card(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 175,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage("${cartItems[index][3]}"),
                                    fit: BoxFit.fill,
                                  )
                                ),
                              ),
                              SizedBox(width: 30,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cartItems[index][0]),
                                      SizedBox(height: 10,),
                                      // ignore: avoid_unnecessary_containers
                                      
                                        // Container(
                                        //   // width: 60,
                                        //   // child: Text(cartItems[index][1], maxLines: 2,),
                                        //   child: Text("Jack and Jones", maxLines: 2,),
                                        // ),
      
                                      Container(
                                          // width: 60,
                                          // child: Text(orderItems[index]["itemname"], maxLines: 2,),
                                          // child: Text("Jack and Jones", maxLines: 2,),
                                          child: SizedBox(
                                            width: 120,
                                            child: Text(cartItems[index][1], maxLines: 3, 
                                            style: TextStyle(fontSize: 14),),
                                          ),
                                        ),
                                      
                                      SizedBox(height: 10,),
                                      Container(
                                        // child: Text("M"),
                                        child: Text("Size ${cartItems[index][7]}"),
                                      ),
      
                                      SizedBox(height: 10,),
                                      Container(
                                        // child: Text('\u{20B9} ${cartItems[index][2]}'),
                                        child: Text('\u{20B9} ${itemCost}'),
                                      ),
                        
                                      SizedBox(height: 10,),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if (cartItems[index][4]>1) InkWell(
                                            onTap: (){
                                              setState(() {
                                                cartItems[index][4]=cartItems[index][4]-1;
                                              });
                                            },
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                size: 15,
                                                ),
                                            ),
                                          ),
                        
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text("${cartItems[index][4]}"),
                                          ),
                        
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                cartItems[index][4]=cartItems[index][4]+1;
                                              });
                                            },
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 15,
                                                ),
                                             ),
                                          ),
                        
                                        ],
                                      ),
                        
                                      
                                    ],
                                  ),
                                ),
                              ),
                              // ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    cartItems.removeAt(index);
                                    boxx.put('items', cartItems);
                                    setState(() {
                                      cartItems = cartItems;
                                    });
                                    // Navigator.pop(context);
                                    // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> super.widget));
                                    // print(cartItems[index]);
                                    // boxx.getAt(0);
                                    // boxx.delete(boxx.getAt(0)[index]);
                                    // print(boxx.getAt(0)[index]);
                                  },
                                  child: Icon(Icons.close, size: 20,)
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                        
                    ),
                ),
              ),
              
              SizedBox(height: 10,),
        
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: (){
                        var orderlist = [];
                        var myorderslist = [];
                      for(var i=0; i<cartItems.length; i++){
                        orderlist.add(
                          {
                            'store': cartItems[i][0].toString(),
                            'item': cartItems[i][5].toString(),
                          }
                        );
                        myorderslist.add(
                          {
                            'store': cartItems[i][0].toString(),
                            'itemname': cartItems[i][1].toString(),
                            'price': cartItems[i][2],
                            'image': cartItems[i][3],
                            'size': cartItems[i][7],
                          }
                        );
                      }
                      
                      print(myorderslist);
                        showModalBottomSheet(context: context, builder: (context) => ShowTotBill(totbagcost: bagtotcost, orderlist: orderlist, myorderslist: myorderslist,));
                      },
                      color: Colors.indigo[300],
                      // minWidth: double.infinity,
                      // minWidth: MediaQuery.of(context).size.width,
                      minWidth: MediaQuery.of(context).size.width*0.9,
                      height: 50,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Text("Proceed to Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      ),
                      ),
                  ],
                ),
              ),
              ]
        ),
    );
  }
}