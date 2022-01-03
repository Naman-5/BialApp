import 'package:flutter/material.dart';

Map<String, TextStyle> textStyles = {
  'h1': TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade600,
  ),
  'h2': const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  ),
  'h3': TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade400,
  ),
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
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LostItemClaimPage(lostItem: lostItem)));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lostItem.itemName, style: textStyles['h1']),
              Text("${lostItem.date.toLocal()}".split(' ')[0],
                  style: textStyles['h4'])
            ],
          ),
          Row(
            children: [
              Text('ItemID', style: textStyles['h2']),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${lostItem.id}',
                style: textStyles['h3'],
              )
            ],
          ),
          Row(children: [
            Text(
              'Location',
              style: textStyles['h2'],
            ),
            Text('${lostItem.loc}', style: textStyles['h3'])
          ])
        ]),
      ),
    );
  }
}

class LostItemClaimPage extends StatelessWidget {
  const LostItemClaimPage({Key? key, required this.lostItem}) : super(key: key);
  final LostItem lostItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: Colors.grey[400],
            )),
        title: Text('Claim'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(),
        ),
      ),
    );
  }
}

class CalendarButton extends StatefulWidget {
  CalendarButton({Key? key, required this.dateText, required this.dateTime})
      : super(key: key);

  String dateText;
  DateTime dateTime;

  @override
  _CalendarButtonState createState() => _CalendarButtonState();
}

class _CalendarButtonState extends State<CalendarButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now());
        setState(() {
          widget.dateText = "${picked?.toLocal()}".split(' ')[0];
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade400)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.dateText,
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
    );
  }
}

class LostFoundPage extends StatefulWidget {
  const LostFoundPage({Key? key}) : super(key: key);

  @override
  _LostFoundPageState createState() => _LostFoundPageState();
}

class _LostFoundPageState extends State<LostFoundPage> {
  String _fromDateText = "From";
  String _toDateText = "To";
  DateTime _fromDateTime = DateTime.now();
  DateTime _toDateTime = DateTime.now();

  List<LostItemWidget> lostItemsList = [
    LostItemWidget(
        lostItem: LostItem(
            id: 1000,
            itemName: 'qwerty',
            loc: 'qwertyloc',
            date: DateTime(2020))),
    LostItemWidget(
        lostItem: LostItem(
            id: 1000,
            itemName: 'qwerty',
            loc: 'qwertyloc',
            date: DateTime(2020))),
  ];

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
                    dateText: _fromDateText, dateTime: _fromDateTime),
                CalendarButton(dateText: _toDateText, dateTime: _toDateTime),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
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
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: lostItemsList,
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
