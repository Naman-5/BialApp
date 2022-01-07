import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'helper/check_signin.dart';
import 'sign_up.dart';
import 'home_screen.dart';

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
          margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (String text) {
                    _RequestData.flightNo = text;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Enter Flight Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (String text) {
                    _RequestData.PNR = text;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Enter Flight PNR Number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (String text) {
                    _RequestData.pickUp = text;
                  },
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
                  onTap: () async {
                    // add wheel chair API
                    var url = Uri.parse(
                        'https://bialapp.azurewebsites.net/api/wheelChairRequest?code=H8c6UGObspp8nHbuwntYav/kHzyNuF0R15/D85FqHkOCkOsQUWpfyg==');
                    try {
                      const storage = FlutterSecureStorage();
                      var response = await http.post(url,
                          body: json.encode({
                            'token': await storage.read(key: "signInToken"),
                            'flightNo': _RequestData.flightNo.toString(),
                            'PNR': _RequestData.PNR.toString(),
                            'pickup': _RequestData.pickUp.toString()
                          }));
                      var message = json.decode(response.body);
                      showDialog(
                          context: context,
                          builder: (constext) {
                            return AlertDialog(
                              title:
                                  const Text("Successful WheelChair Request"),
                              content: SizedBox(
                                child: Text(message['message']),
                                // width: MediaQuery.of(context).size.width,
                                height: 200,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          });
                    } on Exception {
                      showDialog(
                          context: context,
                          builder: (constext) {
                            return AlertDialog(
                              title: const Text("WheelChair Request Failed"),
                              content: const SizedBox(
                                child: Text(
                                    'Sorry! Your Wheelchair Request was not registered. Please try again'),
                                // width: MediaQuery.of(context).size.width,
                                height: 200,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          });
                    }
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
                      child: const Center(
                        child: Text("Book Wheel Chair"),
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}

class _RequestData {
  static String flightNo = "";
  static String PNR = "";
  static String pickUp = "";
}
