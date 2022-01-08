import 'package:flutter/material.dart';
// import 'package:genie/retail/shopspreview/components/header.dart';
import 'package:genie/retail/shopitems/body.dart';
import 'package:genie/retail/shopitems/header.dart';

class ShopItems extends StatefulWidget {
  final List shops;
  const ShopItems({ Key? key, required this.shops }) : super(key: key);

  @override
  _ShopItemsState createState() => _ShopItemsState();
}

class _ShopItemsState extends State<ShopItems> {
  @override
  Widget build(BuildContext context) {
    // int ind = 0;
    // print('${ind+1}');
    // var shops = ModalRoute.of(context).settings.arguments;
    // print(widget.shops[0]["itemDetails"]['${ind+1}']);
    // print(widget.shops);
    int ListLength = widget.shops[0]["itemDetails"].length;
    // print(ListLength);

    return Scaffold(
      // appBar: ShopHeader(),
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShopHeader(),
              // SizedBox(height: 20),
              Expanded(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.builder(
                    itemCount: ListLength,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.65,
                    ), 
                    // shopps: shopss[index],
                    itemBuilder: (context, index) => ItemsBody(shopps: [widget.shops[0]["itemDetails"]['${index+1}']], ind: index+1, shopname: widget.shops[0]["id"])),
                ),
              ),),
                ],
        ),
    );
  }
}