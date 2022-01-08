import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../sign_up.dart';
import 'helper/check_signin.dart';
import 'common_variables.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _customWebsite =
    'https://www.cbic.gov.in/resources//htdocs-cbec/customs/forms_pdf/cs-bgge-declare-form1-ason19feb2014.pdf';

class CustomsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            return const SignUP();
          } else {
            return _CustomDeclaration();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: CheckSignIn.check(),
    );
  }
}

class _CustomDeclaration extends StatelessWidget {
  // passport number text editing controller
  final pnoController = TextEditingController();
  final flightNumber = TextEditingController();
  final baggages = TextEditingController();
  final countriesVisitedLastSixDays = TextEditingController();
  final valueOfGoods = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Customs Declaration Form'),
          backgroundColor: Colors.indigo[300]),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
        child: Column(
          children: [
            // Passport Number
            Row(
              children: [
                const Text('Passport Number: '),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  controller: pnoController,
                  onChanged: (String text) {
                    CustomFormData.passportNumber = text;
                  },
                ))
              ],
            ),
            // Date of Arrival
            Row(
              children: const [
                Text("Date of Arrival"),
                DateSelectButton(),
              ],
            ),
            // Flight Number
            Row(
              children: [
                const Text('Flight Number: '),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  controller: flightNumber,
                  onChanged: (String text) {
                    CustomFormData.flightNumber = text;
                  },
                ))
              ],
            ),
            // Number of Baggages
            Row(
              children: [
                const Text('Number of Baggages (including hand baggages):'),
                Expanded(
                    child: TextField(
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: baggages,
                  onChanged: (String text) {
                    CustomFormData.baggages = text;
                  },
                ))
              ],
            ),
            // country from where is the person is arriving
            Row(
              children: const [
                Text('Country from where coming:'),
              ],
            ),
            Row(
              children: [
                DropDownSelector(
                    options: nationalities, type: "arrivingCountry")
              ],
            ),
            // countries visited in the last six days
            Column(
              children: [
                const Text('Countries visited in the last six days:'),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      controller: countriesVisitedLastSixDays,
                      onChanged: (String text) {
                        CustomFormData.countriesVisitedLastSixDays = text;
                      },
                    ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // value of dutiable goods being imported
            Column(
              children: [
                const Text(
                    'Total value of dutiable goods being imported (Rs.)'),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      controller: valueOfGoods,
                      onChanged: (String text) {
                        CustomFormData.value = text;
                      },
                    ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Yes or No Questionaire Begins
            const Text(
              'Are you bringing the following items into India?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // prohibited articles
            Row(
              children: const [
                Text('Prohibited Articles: '),
              ],
            ),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '0'),
              ],
            ),
            // gold jewellery
            Row(
              children: const [
                Text('Gold jewellery (over Free Allowance): '),
              ],
            ),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '1'),
              ],
            ),
            // gold bullion
            Row(
              children: const [
                Text('Gold Bullion: '),
              ],
            ),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '2'),
              ],
            ),
            // meat products
            const Text(
                'Meat and meat products/dairy products/fish/poultry products:'),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '3'),
              ],
            ),
            // seeds or plants etc.
            const Text(
                'Seeds/plants/seeds/fruits/flowers/other planting material:'),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '4'),
              ],
            ),
            // Satellite phone
            Row(
              children: const [
                Text('Satellite phone:'),
              ],
            ),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '5'),
              ],
            ),
            // Indian Currency exceeding
            Row(
              children: const [
                Text('Indian currency exceeding Rs. 10,000/- :'),
              ],
            ),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '6'),
              ],
            ),
            // foreign Currency exceeding
            const Text(
                'Foreign currency notes exceed US \$ 5,000 or equivalent:'),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '7'),
              ],
            ),
            const Text(
                'Aggregate value of foreign exchange including currency exceeds US \$ 10,000 or equivalent.'),
            Row(
              children: [
                DropDownSelector(
                    options: const ['Select', 'Yes', 'No'], type: '8'),
              ],
            ),

            IconButton(
                onPressed: () async {
                  var answers = [];
                  for (var i in CustomFormData.questions.keys) {
                    answers.add(CustomFormData.questions[i]);
                  }
                  var url = Uri.parse(
                      'https://bialapp.azurewebsites.net/api/customs?code=l0yor27Vaoa9rrSPo1q2Xhvb/44RsKgyUKS6qOuSHvDku1rjkMQnSA==');
                  try {
                    const storage = FlutterSecureStorage();
                    var response = await http.post(url,
                        body: json.encode({
                          'token': await storage.read(key: "signInToken"),
                          'passport-no': CustomFormData.passportNumber,
                          'arrival-date': CustomFormData.arrivalDate.toString(),
                          'flight-no': CustomFormData.flightNumber,
                          'coming-from': CustomFormData.arrivingCountry,
                          'no-baggage': CustomFormData.baggages,
                          'countries-visited':
                              CustomFormData.countriesVisitedLastSixDays,
                          'value': CustomFormData.value,
                          'questions': answers,
                        }));
                    var message = json.decode(response.body);
                    showDialog(
                        context: context,
                        builder: (constext) {
                          return AlertDialog(
                            title: const Text("Custom Declaration Status"),
                            content: SizedBox(
                              child: Text(message['message']),
                              // width: MediaQuery.of(context).size.width,
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
                            title: const Text("Custom Declaration Status"),
                            content: const SizedBox(
                              child: Text('Something went wrong. Try again'),
                              // width: MediaQuery.of(context).size.width,
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
                icon: const Icon(
                  Icons.send_sharp,
                  color: Colors.indigo,
                )),

            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _FormView(_customWebsite)));
                },
                child: const Text(
                  'More Details',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.indigo),
                ))
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class DropDownSelector extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  late List<String> options = ['Select'];
  late String type = 'Unkown';
  DropDownSelector({Key? key, required this.options, required this.type})
      : super(key: key);

  @override
  State<DropDownSelector> createState() =>
      // ignore: no_logic_in_create_state
      _DropDownSelectorState(options, type);
}

class _DropDownSelectorState extends State<DropDownSelector> {
  List<String> options = [];
  String type = '';
  _DropDownSelectorState(this.options, this.type);
  String dropdownValue = 'Select';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.deepPurple,
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          if (type == 'arrivingCountry') {
            CustomFormData.arrivingCountry = dropdownValue;
          } else {
            CustomFormData.questions[type] = dropdownValue;
          }
        });
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
              width: 180,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontSize: 13),
              ),
            ));
      }).toList(),
    );
  }
}

class DateSelectButton extends StatefulWidget {
  const DateSelectButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DateSelectButtonState();
}

class DateSelectButtonState extends State<DateSelectButton> {
  void callSelector() {}
  void _onSelectionChanged(DateTime args) {
    CustomFormData.arrivalDate = args;
  }

  void showSelector(BuildContext context) async {
    showDialog(
        context: context,
        builder: (constext) {
          return AlertDialog(
            title: const Text("Select Date of Birth"),
            content: SizedBox(
              child: CalendarDatePicker(
                  initialDate: CustomFormData.arrivalDate,
                  firstDate: DateTime.parse('1900-01-01'),
                  lastDate: DateTime.now(),
                  onDateChanged: _onSelectionChanged),
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
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

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => showSelector(context),
        child: const Icon(
          Icons.date_range_rounded,
          color: Colors.indigo,
        ));
  }
}

class _FormView extends StatelessWidget {
  String website = "";
  late WebViewController _controller;
  _FormView(this.website);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: website,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewcontroller) {
          _controller = webViewcontroller;
        },
      ),
    );
  }
}

class CustomFormData {
  static String passportNumber = "Select";
  static String nationality = "Select";
  static String flightNumber = "Select";
  static var arrivalDate = DateTime.now();
  static String baggages = "0";
  static String arrivingCountry = "Select";
  static String countriesVisitedLastSixDays = "Select";
  static String value = "Select";
  static var questions = {};
}
