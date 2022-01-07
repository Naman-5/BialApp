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

                  // onPressed: () { },
                );
              },
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: 70,
          //   decoration: BoxDecoration(color: Colors.black),
          //   child: Icon(Icons.close, color: Colors.white,),
          // ),
          Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              // shrinkWrap: true,
              // primary: false,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (BuildContext context, index){
                return GestureDetector(
                  onTap: (){
                
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          width: 175,
                          height: 130,
                          child: Image.asset('assets/images/test.png',
                          fit: BoxFit.cover,),
                        ),
                        // Padding(padding: EdgeInsets.all(25)),
                        SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Jack and Jones"),
                            SizedBox(height: 10,),
                            Container(
                              // width: 60,
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
        ),
              ],
            );
  }
}