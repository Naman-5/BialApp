import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyOrders extends StatefulWidget {
  // final List myorders;
  const MyOrders({ Key? key, }) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    
    int lengthh;
    Box boxx = Hive.box('myOrders');
    List orderItems = boxx.get('items');
    if (orderItems.isEmpty) lengthh = 0;
    else lengthh = orderItems.length;
    print(orderItems);


return Scaffold(
      appBar: AppBar(
                  backgroundColor: Colors.indigo[300],
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close,)),
                    title: Text("Orders"),
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
                    return GestureDetector(
                      onTap: (){
                         
                      },
                      child: Card(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 175,
                              // height: 150,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage("${orderItems[index]["image"]}"),
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
                                    Text(orderItems[index]["store"]),
                                    SizedBox(height: 10,),
                                    
                                      Container(
                                        // width: 60,
                                        // child: Text(orderItems[index]["itemname"], maxLines: 2,),
                                        // child: Text("Jack and Jones", maxLines: 2,),
                                        child: SizedBox(
                                          // width: 80,
                                          width: 120,
                                          child: Text(orderItems[index]["itemname"], maxLines: 3, 
                                          style: TextStyle(fontSize: 14),),
                                        ),
                                      ),
                                    
                                    SizedBox(height: 10,),
                                    Container(
                                      // child: Text("M"),
                                      child: Text("Size ${orderItems[index]["size"]}"),
                                    ),

                                    SizedBox(height: 10,),
                                    Container(
                                      // child: Text('\u{20B9} ${cartItems[index][2]}'),
                                      child: Text('\u{20B9} ${orderItems[index]["price"]}'),
                                    ),
                      
                                    // SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    } 
                  ),
              ),
            ),
            
            SizedBox(height: 10,),
            ]
            
      ),
    );






    // return Column(
    //     children: <Widget>[
    //       AppBar(
    //         backgroundColor: Colors.black,
    //         leading: Builder(
    //           builder: (BuildContext context) {
    //             return IconButton(
    //               icon: const Icon(Icons.close),
    //               onPressed: () => Navigator.pop(context),

    //               // onPressed: () { },
    //             );
    //           },
    //         ),
    //       ),
    //       // Container(
    //       //   width: double.infinity,
    //       //   height: 70,
    //       //   decoration: BoxDecoration(color: Colors.black),
    //       //   child: Icon(Icons.close, color: Colors.white,),
    //       // ),
    //       Expanded(
    //       child: MediaQuery.removePadding(
    //         context: context,
    //         removeTop: true,
    //         child: ListView.builder(
    //           // shrinkWrap: true,
    //           // primary: false,
    //           // physics: NeverScrollableScrollPhysics(),
    //           itemCount: lengthh,
    //           itemBuilder: (BuildContext context, index){
    //             return GestureDetector(
    //               onTap: (){
                
    //               },
    //               child: Card(
    //                 child: Row(
    //                   children: [
    //                     Container(
    //                       width: 175,
    //                       height: 150,
    //                       child: Image.network(orderItems[index][0]["image"],
    //                       // child: Image.asset('assets/images/test.png',
    //                       fit: BoxFit.cover,),
    //                     ),
    //                     // Padding(padding: EdgeInsets.all(25)),
    //                     SizedBox(width: 30,),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(orderItems[index][0]["store"]),
    //                         SizedBox(height: 10,),
    //                         Container(
    //                           // width: 60,
    //                           child: Text(orderItems[index][0]["itemname"]),
    //                         ),
    //                         SizedBox(height: 10,),
    //                         Container(
    //                           // width: 60,
    //                           child: Text("Size ${orderItems[index][0]["size"]}"),
    //                         ),
    //                         SizedBox(height: 10,),
    //                         Container(
    //                           child: Text('\u{20B9} ${orderItems[index][0]["price"]}'),
    //                         ),
    //                       ],
    //                     ),
                
    //                   ],
    //                 ),
    //               ),
    //             );
    //           },
                
    //           ),
    //       ),
    //     ),
    //           ],
    //         );
  }
}