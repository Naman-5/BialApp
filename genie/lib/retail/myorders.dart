import 'package:flutter/material.dart';


class MyOrders extends StatefulWidget {
  const MyOrders({ Key? key }) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.black,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                );
              },
            ),
          ),
          
          Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (BuildContext context, index){
              return GestureDetector(
                onTap: (){
      
                },
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        width: 125,
                        height: 130,
                        child: Image.asset('assets/images/test.png',
                        fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jack and Jones"),
                          SizedBox(height: 10,),
                          Container(
                            child: Text("Grey Jacket"),
                          ),
                          SizedBox(height: 10,),
      
                          Container(
                            child: Text('\u{20B9} 7000'),
                          ),
                        ],
                      ),
      
                    ],
                  ),
                ),
              );
            },
      
            ),
        ),
              ],
            );
  }
}