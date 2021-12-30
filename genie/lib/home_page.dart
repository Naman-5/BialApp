import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _iconWidgets = const [
    Icons.arrow_back_ios,
    Icons.arrow_back_ios,
    Icons.arrow_back_ios,
    Icons.arrow_back_ios,
    Icons.arrow_back_ios,
    Icons.contact_page_sharp,
  ];

  final _iconLabels = [
    'sample',
    'sample',
    'sample',
    'sample',
    'sample',
    'Airline Contacts',
  ];

  final _iconHandlers = []; // TODO

  Widget generateIcon(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          padding: EdgeInsets.all(17),
          onPressed: () {},
          color: Colors.grey[100],
          shape: const CircleBorder(),
          child: Icon(
            _iconWidgets[index],
            size: 25,
            color: Colors.grey[600],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(_iconLabels[index]),
        )
      ],
    );
  }

  Widget generateCards(index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 100,
      width: 200,
      color: Colors.grey[200],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Container(
            height: height / 2.2,
            child: Image.asset(
              'assets/images/airport3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height / 2.4),
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                    child: Text(
                      'Highlights',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    )),
                Container(
                  height: 100,
                  width: width,
                  child: ListView(
                    children: List.generate(4, (index) => generateCards(index)),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, generateIcon),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        List.generate(3, (index) => generateIcon(index + 3)),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
