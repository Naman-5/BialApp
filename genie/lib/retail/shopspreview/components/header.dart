import 'package:flutter/material.dart';
import 'package:genie/retail/cart.dart';



class ShopHeader extends StatefulWidget {
  const ShopHeader({ Key? key }) : super(key: key);

  @override
  _ShopHeaderState createState() => _ShopHeaderState();
}

class _ShopHeaderState extends State<ShopHeader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Padding(padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   child: IconButton(
                  //   icon: Icon(Icons.arrow_back),
                  //   onPressed: (){
                  //     Navigator.pop(context);
                  //   },)
                  // ),
                  Container(
                    // width: 300,
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        // Search value
                      },
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Search Product",
                        contentPadding: EdgeInsets.all(20.0),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),

                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: new IconButton(
                        icon: new Icon(Icons.shopping_cart),
                        // highlightColor: Colors.blue,
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(context)=> CartPage()));
                        },
                      ),
                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
}