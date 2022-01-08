import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genie/helper/check_signin.dart';
import 'package:genie/retail/bialrewards.dart';
import 'package:genie/retail/myorders.dart';
import 'package:genie/sign_up.dart';
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_outlined))
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
    var body = {'token': await secureStorage.read(key: 'signInToken')};
    var response = await http.post(url, body: json.encode(body));
    return json.decode(response.body);
  }

  Widget getprofileUI(BuildContext context, Map data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.35 - 40 / 0.35,
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
                    padding: const EdgeInsets.symmetric(vertical: 25),
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
                          backgroundColor: Colors.grey[300],
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
        const BialRewards(),
        const Options(
            label: 'My Orders',
            iconData: Icons.shopping_bag_rounded,
            navigateTo: MyOrders())
      ],
    );
  }
}

class Options extends StatelessWidget {
  const Options(
      {Key? key,
      required this.label,
      required this.iconData,
      required this.navigateTo})
      : super(key: key);

  final String label;
  final IconData iconData;
  final Widget navigateTo;

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
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => navigateTo));
        });
  }
}
