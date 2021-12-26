import 'package:flutter/material.dart';

class ShopsGridView extends StatefulWidget {
  const ShopsGridView({ Key? key }) : super(key: key);

  @override
  _ShopsGridViewState createState() => _ShopsGridViewState();
}

class _ShopsGridViewState extends State<ShopsGridView> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Tap'),
          ));
          },
          child: Container(
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/JackandJones.png')),
                ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
          child: Text("Jack and Jones"),
        )
      ],
    );
  }
}