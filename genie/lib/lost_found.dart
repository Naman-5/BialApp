import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Map<String, TextStyle> textStyles = {
  'h1': TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade600,
      letterSpacing: 1.1),
  'h2': const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
      letterSpacing: 1.07),
  'h3': TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade400,
      letterSpacing: 1.07),
  'h4': TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade400,
  )
};

class LostItem {
  LostItem(
      {required this.id,
      required this.itemName,
      required this.loc,
      required this.date,
      this.desc});

  final int id;
  final String itemName;
  final String loc;
  final String? desc;
  final DateTime date;
}

class LostItemWidget extends StatelessWidget {
  const LostItemWidget({Key? key, required this.lostItem}) : super(key: key);
  final LostItem lostItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LostItemClaimPage(lostItem: lostItem)));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(lostItem.itemName, style: textStyles['h1']),
                Text("${lostItem.date.toLocal()}".split(' ')[0],
                    style: textStyles['h4'])
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text('ItemID', style: textStyles['h2']),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  '${lostItem.id}',
                  style: textStyles['h3'],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(children: [
              Text(
                'Location',
                style: textStyles['h2'],
              ),
              const SizedBox(
                width: 20,
              ),
              Text('${lostItem.loc}', style: textStyles['h3'])
            ])
          ]),
        ),
      ),
    );
  }
}

class LostItemClaimPage extends StatelessWidget {
  const LostItemClaimPage({Key? key, required this.lostItem}) : super(key: key);
  final LostItem lostItem;

  Widget getItemDetailsRow(String field, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            field,
            style: textStyles['h2'],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              value,
              style: textStyles['h3'],
            ),
          ),
        )
      ],
    );
  }

  Widget getInputRow(String field) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          field,
          style: textStyles['h2'],
        ),
        Container(
          width: 150,
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: const TextField(
            decoration: InputDecoration(border: InputBorder.none),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    CalendarController controller =
        CalendarController(dateString: 'Travel Date');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: Colors.grey[400],
            )),
        title: const Text('Claim Item', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(25),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 23.0, bottom: 12),
                      child: Text(
                        'Item Details',
                        style: textStyles['h1'],
                      ),
                    ),
                    getItemDetailsRow('Item', lostItem.itemName),
                    getItemDetailsRow('Item ID', lostItem.id.toString()),
                    getItemDetailsRow('Date',
                        "${lostItem.date.day}/${lostItem.date.month}/${lostItem.date.year}"),
                    getItemDetailsRow('Location', lostItem.loc),
                    getItemDetailsRow('Description', lostItem.desc ?? ""),
                    Padding(
                      padding: const EdgeInsets.only(top: 23.0, bottom: 12),
                      child: Text(
                        'Passenger Details',
                        style: textStyles['h1'],
                      ),
                    ),
                    getInputRow('Name'),
                    getInputRow('Email address'),
                    getInputRow('Mobile Number'),
                    Padding(
                      padding: const EdgeInsets.only(top: 23.0, bottom: 12),
                      child: Text(
                        'Flight Details',
                        style: textStyles['h1'],
                      ),
                    ),
                    getInputRow('Flight Number'),
                    CalendarButton(controller: controller)
                  ],
                ),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.indigo[300]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Submit',
                    style: TextStyle(letterSpacing: 1.3, fontSize: 17)))
          ],
        ),
      ),
    );
  }
}

class CalendarButton extends StatefulWidget {
  CalendarButton({Key? key, required this.controller}) : super(key: key);
  CalendarController controller;

  @override
  _CalendarButtonState createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400)),
      child: InkWell(
        onTap: () async {
          DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2019),
              lastDate: DateTime.now());
          setState(() {
            if (picked != null) {
              widget.controller.dateTime = picked;
              widget.controller.dateString =
                  '${picked.day}-${picked.month}-${picked.year}';
            }
            // widget.dateText = "${picked?.toLocal()}".split(' ')[0];
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.controller.dateString,
                  style: TextStyle(fontSize: 20, color: Colors.grey[400]),
                ),
              ),
              const Icon(
                Icons.calendar_today_rounded,
                size: 30,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarController extends ChangeNotifier {
  CalendarController({
    required this.dateString,
  });
  String dateString;
  DateTime dateTime = DateTime.now();

  DateTime get getDateTime {
    return dateTime;
  }
}

class LostFoundPage extends StatefulWidget {
  const LostFoundPage({Key? key}) : super(key: key);

  @override
  _LostFoundPageState createState() => _LostFoundPageState();
}

class _LostFoundPageState extends State<LostFoundPage> {
  CalendarController fromController = CalendarController(dateString: 'From');
  CalendarController toController = CalendarController(dateString: 'To');

  var lostItemsList = [];

  Future<List<dynamic>> fetchResults(DateTime from, DateTime to) async {
    Map<String, String> body = {
      'info': 'lost&found',
      'start': '${from.month}-${from.day}-${from.year}',
      'end': '${to.month}-${to.day}-${to.year}',
    };

    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/lostandfound?code=TYatTdwaHZwaCKpuJeRicjWbRtyd3MOawKYj0v6%2FEtGTNJ7rbOhrNw%3D%3D');
    var response = await http.post(url, body: json.encode(body));
    if (response.body.isNotEmpty) {
      var resBody = json.decode(response.body);
      return resBody;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    'Lost & Found',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: Colors.grey[600]),
                  ),
                ),
                CalendarButton(
                  controller: fromController,
                ),
                CalendarButton(
                  controller: toController,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      var res = fetchResults(
                              fromController.dateTime, toController.dateTime)
                          .then((value) {
                        setState(() {
                          lostItemsList = value;
                        });
                      });
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(letterSpacing: 1.02, fontSize: 17),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[300]),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: lostItemsList.length,
                    itemBuilder: (_, index) {
                      var item = lostItemsList[index];
                      var dateList = item['date'].split('-');
                      return LostItemWidget(
                          lostItem: LostItem(
                        id: int.parse(item['id']),
                        itemName: item['item'],
                        loc: item['location'],
                        date: DateTime(int.parse(dateList[2]),
                            int.parse(dateList[0]), int.parse(dateList[1])),
                        desc: item.containsKey('description')
                            ? item['description']
                            : "",
                      ));
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10)),
                  backgroundColor: MaterialStateProperty.all(Colors.grey[50]),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey.shade400)))),
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.grey[400],
                size: 30,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
