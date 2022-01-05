import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genie/common_variables.dart';
import 'sign_up_supporter.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

const _airportLogoPath = "ImageAssets/airport_logo.svg";
const _googleLogo = 'ImageAssets/googleLogo.png';
const _outlookLogo = 'ImageAssets/outlookLogo.jpeg';

class SignUP extends StatelessWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Authentication Required"),
      ),
      body: _SignUpUI(),
    );
  }
}

class _SignUpUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 7,
        ),
        Flexible(
          flex: 1,
          child: SvgPicture.asset(
            _airportLogoPath,
            height: 175,
          ),
          fit: FlexFit.tight,
        ),
        Flexible(
          flex: 4,
          child: SingleChildScrollView(
            child: _SignUpTab(),
          ),
          fit: FlexFit.tight,
        ),
      ],
    );
  }
}

class _SignUpTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<_SignUpTab> with TickerProviderStateMixin {
  // variables loginIdentifier and signUPIdentifier are used for comparisons
  // in the switchSection function

  final loginIdentifier = "Login";
  final signUPIdentifier = "Sign-Up";
  var defaultOption = "Login";

  // switchSection function identifies the section to display (login or sign-up)
  // and then sets state to reload the class
  void switchSection(var currentSection) {
    if (currentSection == loginIdentifier &&
        defaultOption == signUPIdentifier) {
      defaultOption = loginIdentifier;
    }
    if (currentSection == signUPIdentifier &&
        defaultOption == loginIdentifier) {
      defaultOption = signUPIdentifier;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () {
                    switchSection(loginIdentifier);
                  },
                  child: const Text("Login")),
              ElevatedButton(
                  onPressed: () {
                    switchSection(signUPIdentifier);
                  },
                  child: const Text("Sign-Up"))
            ],
          ),
        ),
        (defaultOption == loginIdentifier)
            ? SingleChildScrollView(
                child: _LoginSection(),
              )
            : SingleChildScrollView(
                child: _SignUpForm(),
              ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _LoginSection extends StatelessWidget {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  var _providedUserName = '';
  var _providedPassword = '';
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              // --------------------user name section------------------
              Row(
                children: const [
                  Text(
                    "Username",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.white,
                      autocorrect: false,
                      style: TextStyle(color: Colors.grey[800]),
                      // textAlign: TextAlign.center,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'username@example.com',
                        border: UnderlineInputBorder(),
                      ),
                      onChanged: (String text) {
                        _providedUserName = text;
                      },
                      controller: userNameController,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // --------------------password section------------------
              Row(
                children: const [
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.grey[800]),
                      cursorColor: Colors.white,
                      obscureText: true,
                      enableSuggestions: false,
                      decoration: const InputDecoration.collapsed(
                          border: UnderlineInputBorder(), hintText: '🔑'),
                      onChanged: (String text) {
                        _providedPassword = text;
                      },
                      controller: passwordController,
                    ),
                  )
                ],
              ),
              //--------------------------login button and others-----------------
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // const SizedBox(
                  //   width: 250,
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      userNameController.clear();
                      passwordController.clear();
                    },
                    child: const Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(15)),
                  ),
                ],
              ),
              // sign-in with google or outlook
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Image(
                      image: AssetImage(_googleLogo),
                      width: 20,
                      height: 20,
                    ),
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Image(
                      image: AssetImage(_outlookLogo),
                      width: 20,
                      height: 20,
                    ),
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class _SignUpForm extends StatelessWidget {
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var _providedFullName = "";
  // ignore: prefer_typing_uninitialized_variables
  var _providedMobileNumber = '';
  var _email = '';
  var _password = '';
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            //-----------------Provided Full Name------------------
            Row(
              children: const [
                Text(
                  "Full Name",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    autocorrect: false,
                    style: TextStyle(color: Colors.grey[800]),
                    // textAlign: TextAlign.center,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'As on Govt. Issued ID 🆔',
                      border: UnderlineInputBorder(),
                    ),
                    onChanged: (String text) {
                      _providedFullName = text;
                    },
                    controller: fullNameController,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            //----------------User Date of Birth-------------------
            Row(
              children: const [
                Text(
                  "Date of Birth",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                DateSelectButton(),
              ],
            ),
            //---------------Gender Selector-----------------------
            Row(
              children: [
                const Text(
                  "Gender",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropDownSelector(
                  options: const ['Select', 'Male', 'Female', 'Others'],
                  type: 'Gender',
                ),
              ],
            ),
            //----------------Nationality Selector--------------------
            Row(
              children: [
                const Text(
                  "Nationality",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropDownSelector(
                  options: nationalities,
                  type: 'Nationality',
                ),
              ],
            ),
            //----------------Mobile Number Section----------------------
            Row(
              children: [
                const Text(
                  "Code",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropDownSelector(options: mobileCodes, type: 'Codes'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.grey[800]),
                    // textAlign: TextAlign.center,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Mobile Number 123-45-678',
                      border: UnderlineInputBorder(),
                    ),
                    onChanged: (String text) {
                      _providedMobileNumber = text;
                    },
                    controller: mobileNumberController,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            // --------------------email-id section------------------
            Row(
              children: const [
                Text(
                  "Email-id",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    autocorrect: false,
                    style: TextStyle(color: Colors.grey[800]),
                    // textAlign: TextAlign.center,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'username@example.com',
                      border: UnderlineInputBorder(),
                    ),
                    onChanged: (String text) {
                      _email = text;
                    },
                    controller: emailController,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            // --------------------password section------------------
            Row(
              children: const [
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.grey[800]),
                    cursorColor: Colors.white,
                    obscureText: true,
                    enableSuggestions: false,
                    decoration: const InputDecoration.collapsed(
                        border: UnderlineInputBorder(), hintText: '🔑'),
                    onChanged: (String text) {
                      _password = text;
                    },
                    controller: passwordController,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            //--
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var url = Uri.parse(
                        'https://bialapp.azurewebsites.net/api/newusertrigger?code=5ObVhvVPiMKfal7ih6qLfCwSzXvdkJWWtO5tGfGwqcZFg5x31tNIbg%3D%3D');
                    try {
                      var response = await http.post(url,
                          body: json.encode({
                            'id': _email,
                            'fullName': _providedFullName,
                            'DOB': selectedDate,
                            'gender': selectedGender.toLowerCase(),
                            'nationality': selectedNationality,
                            'code': selectedCode.split('-')[0],
                            'mobileNumber': _providedMobileNumber,
                            'password': _password,
                            'method': 'in-app'
                          }));
                      var token = json.decode(response.body);
                      const storage = FlutterSecureStorage();
                      await storage.write(
                          key: 'signInToken', value: token['token']);
                      print(token['token']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    } on Exception {
                      print('failed');
                      fullNameController.text = 'Failed Sign-up';
                      mobileNumberController.text = 'Failed Sign-up';
                      emailController.text = 'Failed Sign-up';
                      passwordController.text = 'Failed Sign-up';
                      Future.delayed(const Duration(seconds: 5), () {});
                    }
                    fullNameController.clear();
                    mobileNumberController.clear();
                    emailController.clear();
                    passwordController.clear();
                  },
                  child: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
