import 'package:flutter/material.dart';



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
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: new IconButton(
                        icon: new Icon(Icons.favorite_outline),
                        onPressed: (){},
                      ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: new IconButton(
                        icon: new Icon(Icons.shopping_cart),
                        onPressed: (){},
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