import 'package:flutter/material.dart';
import 'helper/check_signin.dart';
import 'sign_up.dart';

class WheelChairAssistance extends StatelessWidget {
  const WheelChairAssistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            return const SignUP();
          } else {
            return const WheelChairAssistanceButton();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: CheckSignIn.check(),
    );
  }
}

class WheelChairAssistanceButton extends StatefulWidget {
  const WheelChairAssistanceButton({Key? key}) : super(key: key);

  @override
  _WheelChairAssistanceState createState() => _WheelChairAssistanceState();
}

class _WheelChairAssistanceState extends State<WheelChairAssistanceButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Enter Flight Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Enter Flight PNR Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Enter Pick Up point",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    // add wheel chair API
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: Text("Book Wheel Chair"),
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
