import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genie/helper/check_signin.dart';
import 'package:genie/retail/bialrewards.dart';
import 'package:genie/retail/myorders.dart';
import 'package:genie/sign_up.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CheckSignIn.check(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data == false ? const SignUP() : const UserProfile();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        title: const Text('User Profile'),
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                const storage = FlutterSecureStorage();
                await storage.delete(key: 'signInToken');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: FutureBuilder(
        future: fetchUserDetails(),
        builder: (context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            var dummyData = {
              'message': {'role': 'user', 'name': '', 'id': ''}
            };
            return getprofileUI(context, snapshot.data ?? dummyData);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<Map> fetchUserDetails() async {
    const secureStorage = FlutterSecureStorage();
    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/userdetails?code=hlyj93xPxofSwwz3J54lTCR0lK8A%2FXKl3kUgFwc9pHyMQwsAxxKLDg%3D%3D');
    try {
      var body = {'token': await secureStorage.read(key: 'signInToken')};
      var response = await http.post(url, body: json.encode(body));
      var valueToReturn = json.decode(response.body);
      valueToReturn['message']['rewards'] =
          (valueToReturn['message']['rewards']).toString();
      return valueToReturn;
    } on Exception {
      Map<String, Map<String, String>> x = {
        'message': {'role': 'user', 'name': '', 'id': '', 'rewards': '0'}
      };
      return x;
    }
  }

  Widget getprofileUI(BuildContext context, Map data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Stack(
              children: [
                Container(
                    height:
                        MediaQuery.of(context).size.height * 0.35 - 40 / 0.35,
                    decoration: BoxDecoration(
                        color: Colors.indigo[300],
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)))),
                Positioned(
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 50,
                                color: Colors.indigo.withOpacity(0.23))
                          ]),
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        children: [
                          CircleAvatar(
                            minRadius: 40,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.account_circle_rounded,
                              size: 80,
                              color: Colors.indigo[300],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            data['message']['name'],
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.1),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            data['message']['id'],
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 17,
                                letterSpacing: 1.1),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          BialRewards(
            points: data['message']['rewards'],
          ),
          Options(
              label: 'My Orders',
              iconData: Icons.shopping_bag_rounded,
              onTapHandler: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyOrders()));
              }),
          Options(
            label: 'Boarding Pass',
            iconData: Icons.airplane_ticket_rounded,
            onTapHandler: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Text('Boarding Pass'),
                      actions: [
                        PassDialogBox(),
                      ],
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}

class PassDialogBox extends StatefulWidget {
  const PassDialogBox({Key? key}) : super(key: key);

  @override
  _PassDialogBoxState createState() => _PassDialogBoxState();
}

class _PassDialogBoxState extends State<PassDialogBox> {
  var flightNoController = TextEditingController();
  var pnrController = TextEditingController();
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: isSubmitted
            ? BoardingPass(
                flightNo: flightNoController.text,
                pnr: pnrController.text,
              )
            : PassForm(
                flightNoController: flightNoController,
                pnrController: pnrController,
                submitHandler: () {
                  setState(() {
                    isSubmitted = true;
                  });
                },
              ));
  }
}

class BoardingPass extends StatelessWidget {
  const BoardingPass({Key? key, required this.flightNo, required this.pnr})
      : super(key: key);
  final String flightNo;
  final String pnr;

  Future<Map> fetchBoardingPassDetails(String flightNo, String pnr) async {
    const secureStorage = FlutterSecureStorage();
    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/boardingpass?code=HwPgnocZeyUvcnXpLJ6a2T8TraVdqxCqGTZ1BeNvCTJAuMaEQ1kIwQ%3D%3D');
    var body = {
      'token': await secureStorage.read(key: 'signInToken'),
      'flightNo': flightNo,
      'PNR': pnr,
    };
    try {
      var response = await http.post(url, body: json.encode(body));
      return json.decode(response.body);
    } on Exception {
      return {
        'message': {'name': '', 'seat': '', 'class': ''}
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Colors.indigo.withOpacity(0.33))
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      // height: MediaQuery.of(context).size.height * 0.4,
      // width: MediaQuery.of(context).size.width * 0.7,
      child: FutureBuilder(
          future: fetchBoardingPassDetails(flightNo, pnr),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    snapshot.data!['message']['name'],
                    style: TextStyle(fontSize: 27, letterSpacing: 1.1),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Flight No.',
                          style: TextStyle(fontSize: 17, letterSpacing: 1.1),
                        ),
                        Text(flightNo),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Seat',
                          style: TextStyle(fontSize: 17, letterSpacing: 1.1),
                        ),
                        Text(snapshot.data!['message']['seat']),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Class',
                          style: TextStyle(fontSize: 17, letterSpacing: 1.1),
                        ),
                        Text(snapshot.data!['message']['class']),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class PassForm extends StatelessWidget {
  const PassForm(
      {Key? key,
      required this.flightNoController,
      required this.pnrController,
      required this.submitHandler})
      : super(key: key);
  final TextEditingController flightNoController;
  final TextEditingController pnrController;
  final Function submitHandler;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 25),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: flightNoController,
            decoration: const InputDecoration(
                hintText: 'Enter Flight Number', border: InputBorder.none),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 25),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: pnrController,
            decoration: const InputDecoration(
                hintText: 'Enter PNR Number', border: InputBorder.none),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo[300])),
            onPressed: () {
              submitHandler();
            },
            child: Text('Submit'))
      ],
    );
  }
}

class Options extends StatelessWidget {
  const Options({
    Key? key,
    required this.label,
    required this.iconData,
    required this.onTapHandler,
  }) : super(key: key);

  final String label;
  final IconData iconData;
  final void Function() onTapHandler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Icon(
                  iconData,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              )
            ],
          ),
        ),
        onTap: onTapHandler);
  }
}
