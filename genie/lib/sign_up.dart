import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _airportLogoPath = "ImageAssets/airport_logo.svg";
const _googleLogo = 'ImageAssets/googleLogo.png';
const _outlookLogo = 'ImageAssets/outlookLogo.jpeg';

class SignUP extends StatelessWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _SignUpUI(),
    );
  }
}

class _SignUpUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: SvgPicture.asset(
            _airportLogoPath,
            height: 175,
          ),
          fit: FlexFit.tight,
        ),
        Flexible(
          flex: 2,
          child: _SignUpTab(),
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
            : Column(
                children: const [Text("Sign-up")],
              ),
      ],
    );
  }
}

class _LoginSection extends StatelessWidget {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  var _providedUserName;
  var _providedPassword;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.blue,
      child: Column(
        children: [
          // --------------------user name section------------------
          Row(
            children: const [
              SizedBox(
                width: 20,
              ),
              Text(
                "Username",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  cursorColor: Colors.white,
                  // textAlign: TextAlign.center,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'username@example.com',
                    border: UnderlineInputBorder(),
                    fillColor: Colors.white,
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
            height: 10,
          ),
          // --------------------password section------------------
          Row(
            children: const [
              SizedBox(
                width: 20,
              ),
              Text(
                "Password",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: TextField(
                  cursorColor: Colors.white,
                  obscureText: true,
                  enableSuggestions: false,
                  decoration: const InputDecoration.collapsed(
                      border: UnderlineInputBorder(), hintText: ''),
                  onChanged: (String text) {
                    _providedPassword = text;
                  },
                  controller: passwordController,
                ),
              )
            ],
          ),
          //--------------------------login button and others-----------------
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
                style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
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
                style: OutlinedButton.styleFrom(backgroundColor: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
