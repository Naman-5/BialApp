import 'package:flutter/material.dart';
import 'package:genie/retail/productdetail.dart';


class ItemsBody extends StatefulWidget {
  final List shopps;
  final int ind;
  final String shopname;
  const ItemsBody({ Key? key, required this.shopps, required this.ind, required this.shopname }) : super(key: key);

  @override
  _ItemsBodyState createState() => _ItemsBodyState();
}

class _ItemsBodyState extends State<ItemsBody> {
  @override
  Widget build(BuildContext context) {

    // print(widget.shopps[0]);
    int shoppslength = widget.shopps.length;
    // print(widget.shopps[0]["itemDetails"]);
    // print(widget.shopps[0][0]["itemDetails"]["1"]);
    // print(widget.ind);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=> ProductDetailss(itemdet: widget.shopps, ind: widget.ind, shopname: widget.shopname)));
            },
            child: Expanded(
              child: Container(
                  // padding: EdgeInsets.all(20.0),
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  height: 180,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      // image: AssetImage('assets/images/JackandJones.png')),
                      image: NetworkImage("${widget.shopps[0]["images"][0]}")),
                    ),
                  // child: Image.asset('assets/images/JackandJones.png'),
              ),
            ),
          ),
          // Padding(
          // padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
          // child: Expanded(child: Text(widget.shopps[0]["name"])),
          // ),
          Expanded(child: Text(widget.shopps[0]["name"],
          maxLines: 2,
          ),)
          // Text(widget.shopps[0]["name"]),
        // Text("Jack and Jones"),
      ],
    );
  }
}