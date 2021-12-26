// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CartPage extends StatefulWidget {
  const CartPage({ Key? key }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          AppBar(
            backgroundColor: Colors.black,
            leading: Icon(Icons.close,),
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
                            // width: 60,
                            child: Text("Grey Jacket"),
                          ),
                          SizedBox(height: 10,),
      
                          Container(
                            child: Text('\u{20B9} 7000'),
                          ),
      
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
      
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
                                child: Text("1"),
                              ),
      
                              InkWell(
                                onTap: (){
                                  
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
      
                    ],
                  ),
                ),
              );
            },
      
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
                  showModalBottomSheet(context: context, builder: (context) => showBill());
                },
                color: Colors.cyan,
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
                onPressed: (){},
                color: Colors.cyan,
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
        );
  }

  
  Widget showBill() => Column(
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Redeem Reward Points"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Checkbox(value: true, onChanged: (value) => {}),
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
            child: Text('\u{20B9} 7000'),
          ),
        ],
      ),

      Row(
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