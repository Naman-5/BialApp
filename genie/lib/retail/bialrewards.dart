import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BialRewards extends StatefulWidget {
  const BialRewards({Key? key}) : super(key: key);

  @override
  _BialRewardsState createState() => _BialRewardsState();
}

class _BialRewardsState extends State<BialRewards> {
  @override
  Widget build(BuildContext context) {
    Box rewbox = Hive.box('rewards');
    var rews = rewbox.get('currRew');
    // print(rews);

    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30),
                child: Icon(
                  Icons.card_giftcard_rounded,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Rewards',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )
            ],
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("BIAL Reward Points"),
              actions: [
                Image.asset(
                  "assets/images/rewards.gif",
                  fit: BoxFit.fill,
                ),
                Center(child: Text("${rews} BIAL Points")),
                Center(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          "Reedem BIAL Rewards points at the time of purchase.")),
                ),
              ],
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
        });
  }
}
