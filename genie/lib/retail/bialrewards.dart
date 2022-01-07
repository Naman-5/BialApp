import 'package:flutter/material.dart';


class BialRewards extends StatefulWidget {
  const BialRewards({ Key? key }) : super(key: key);

  @override
  _BialRewardsState createState() => _BialRewardsState();
}

class _BialRewardsState extends State<BialRewards> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            child: const Text("Press me"),
            onPressed: (){ showDialog(context: context,
            builder: (_)=> AlertDialog(
              title: const Text("BIAL Reward Points"),
              actions: [
                  Image.asset("assets/images/rewards.gif",
                    fit: BoxFit.fill,),
                  Center(child: Text("250 BIAL Points")),
                  Center(child: Padding(padding: EdgeInsets.all(10.0),child: Text("Reedem BIAL Rewards points at the time of purchase.")),
                  ),],
              ),
            
            // builder: (_) => NetworkGiffyDialog(
            //   image: Image.asset(
            //     "assets/images/rewards.gif",
            //     fit: BoxFit.fill,
            //     ), 
            //   title: Text("250 Points"),
            //   description: Text("You have 250 BIAL Points. Reedem BIAL Rewards points at the time of purchase."),
            //   ),
            );
            }
          ),
        ],
      ),
    );
  }
}