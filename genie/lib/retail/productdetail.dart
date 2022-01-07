import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:genie/helper/shops.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class ProductDetailss extends StatefulWidget {
  final List itemdet;
  final int ind;
  final String shopname;
  const ProductDetailss({ Key? key, required this.itemdet, required this.ind, required this.shopname }) : super(key: key);

  @override
  _ProductDetailssState createState() => _ProductDetailssState();
}

class _ProductDetailssState extends State<ProductDetailss> {

  int selectedImage = 0;
  var selectedSizeind = null;
  String selectedSize="";

  // @override
  // void dispose(){
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    var shopdet = ShopDetails.shops;
    int flag=1;
    Box boxx = Hive.box('cartBox');
    List cartItems = boxx.get('items');
    // print(cartItems);
    // print(widget.itemdet);
    // print(widget.ind);
    // print(widget.shopname);
    // List justrying = json.decode(widget.itemdet[0]["size"]);
    // List just = List<String>.from(widget.itemdet[0]["size"]);
    // print(just); // List<dynamic>
    // List tryi = widget.itemdet[0]["size"].map((s) => s as String).toList();
    // print(tryi);
    // var map1 = Map.fromIterable(widget.itemdet[0]["size"] as List);
    // print(map1.keys.toList());
    // var shopss = ShopDetails.shops;
    // print(shopss);
    // print(widget.itemdet);

    return Scaffold(
      body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                // child: PageView(
                //   children: [
                //     for(var i=0; i<3; i++)
                //     Container(
                //       color: Colors.grey[300],
                //       height: 300,
                //       child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgVLOZ-0hQQmseGztTZ6Y9jceTvW2pPCPC2w&usqp=CAU',
                //       fit: BoxFit.cover,),
                //     )
                //   ],
                // ),
                color: Colors.grey[300],
                height: 450,
                // child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgVLOZ-0hQQmseGztTZ6Y9jceTvW2pPCPC2w&usqp=CAU',
                child: Image.network(widget.itemdet[0]["images"][selectedImage],
                fit: BoxFit.fill,),
              ),

              SizedBox(height: 10),

              Container(
                width: double.infinity,
                height: 80,
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                    child: Center(
                      child: ListView.builder(
                        itemCount: widget.itemdet[0]["images"].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => multiImagePreview(index)
                      ),
                    )
                    // multiImagePreview(),
                    // ...List.generate(widget.itemdet[0]["images"].length, (index) => multiImagePreview(index))
                //   ],
                // ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                // child: Text("Jack And Jones T-Shirt"),
                child: Text(widget.itemdet[0]["name"]),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text("Rs. ${widget.itemdet[0]["price"]}"),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text("Select Size"),
              ),

            
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    ...List.generate(widget.itemdet[0]["size"].length, (index) => sizeWidget(index))
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MaterialButton(
                    onPressed: (){},
                    color: Colors.lime,
                    // minWidth: double.infinity,
                    minWidth: 50,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.shopping_cart)
                    ),
                  ),
    
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MaterialButton(
                    onPressed: (){
                      for(var i=0; i<cartItems.length; i++){
                        if(widget.itemdet[0]["name"]==cartItems[i][1] && selectedSize==cartItems[i][7]){
                          flag=0;
                        }
                      }
                      if(flag==1){
                      addItemtoCart(widget.shopname, widget.itemdet[0]["name"], widget.itemdet[0]["price"], widget.itemdet[0]["images"][0], 1, widget.ind, widget.itemdet, selectedSize);
                      }else{
                        print('Item is already in cart');
                      }
                    },
                    color: Colors.cyan,
                    // minWidth: double.infinity,
                    minWidth: 265,
                    height: 50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Text("Add to cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    ),
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ), 
      //   ]
      // ),
    );
      
  }

  Future addItemtoCart(String cmpname, String itemname, String price, String image, int numofprod, int indexofitem, List itemdet, String selectedSize) async {
      final addItem = [
       cmpname = cmpname,
       itemname = itemname,
       price = price,
       image = image,
       numofprod = numofprod,
       indexofitem = indexofitem,
       itemdet = itemdet,
       selectedSize = selectedSize
      ];
      // Map<String, dynamic> addItem () => {
      //   "shopname": cmpname,
      //   "itemname": itemname,
      //   "price": price,
      //   "numofprods": 1,
      // };

      Box boxx = Hive.box('cartBox');
      // List items = boxx.get('items');
      List items = boxx.get('items');
      items.add(addItem);
      boxx.put('items', items);
      // print(boxx.toMap());
      // final box = Boxes.getCartItems();
      // box.add(addItem);
    }


  GestureDetector sizeWidget(index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedSizeind = index;
          selectedSize = widget.itemdet[0]["size"][index];
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
          border: Border.all(
            color: selectedSizeind == index ? Colors.redAccent: Colors.transparent
          ),
        ),
        alignment: Alignment.center,
        child: Text(widget.itemdet[0]["size"][index]),
        ),
      );
  }


  GestureDetector multiImagePreview(index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
                margin: EdgeInsets.all(10),
                    // padding: EdgeInsets.all(5),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: selectedImage == index ? Colors.redAccent: Colors.transparent
                        ),
                      image: DecorationImage(
                        image: NetworkImage(widget.itemdet[0]["images"][index]),
                        fit: BoxFit.cover,
                        ),
                      ),
                      // child: Image.network(widget.itemdet[0]["images"][index], fit: BoxFit.,),
                  ),
    );
  }
}