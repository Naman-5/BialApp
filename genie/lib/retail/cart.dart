// import 'package:flutter/cupertino.dart';
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
  
  @override
  Widget build(BuildContext context) {

    int lengthh;
    Box boxx = Hive.box('cartBox');
    // if(boxx.get("items"))  List cartItems = boxx.get('items'), lengthh = cartItems.length;
    List cartItems = boxx.get('items');
    if (cartItems.isEmpty) lengthh = 0;
    else lengthh = cartItems.length;
    
    // var itemCost = itemCount*cartItems[index][2];
    int bagtotcost=0;
    int roundcost=0;
    int redeem=1;
    var rewards;
    print(rewards);
    // print(cartItems[0]);
    // print(boxx);


    return Scaffold(
      appBar: AppBar(
                  backgroundColor: Colors.black,
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close,)),
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
                              height: 150,
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
                                    
                                      Container(
                                        // width: 60,
                                        // child: Text(cartItems[index][1], maxLines: 2,),
                                        child: Text("Jack and Jones", maxLines: 2,),
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
                      showModalBottomSheet(context: context, builder: (context) => ShowTotBill(totbagcost: bagtotcost,));
                    },
                    color: Colors.cyan,
                    // minWidth: double.infinity,
                    minWidth: 150,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Text("Bill Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    ),
                    ),
      
      
                    MaterialButton(
                    onPressed: () async {
                      const storage = FlutterSecureStorage();
                      var orderlist = [];
                    for(var i=0; i<cartItems.length; i++){
                      orderlist.add(
                        {
                          'store': cartItems[0][0].toString(),
                          'item': cartItems[0][5].toString(),
                        }
                      );
                    }
                    var url = Uri.parse(
                      'https://bialapp.azurewebsites.net/api/checkout?code=JijJ4KYjR6ZB5AvV7mvtaR7e0D4HLvJT1rSjyoBplhrHno8AKEPo5A%3D%3D');
                  try {
                    var response = await http.post(url,
                        body: json.encode({
                            'token': await storage.read(key: "signInToken"),
                            'products': orderlist,
                            'redeem': redeem.toString(),
                        }));
                    var mess = json.decode(response.body);
                    // rewards = mess["message"]["rewards"];
                    // print("response -> ${json.decode(response.body)}");
                    setState(() {
                      rewards = mess["message"]["rewards"];
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyOrders(myorders: cartItems, rewards: rewards,)));
                  } on Exception {
                    print('failed');
                  }
                      
                    },
                    color: Colors.cyan,
                    // minWidth: double.infinity,
                    minWidth: 150,
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