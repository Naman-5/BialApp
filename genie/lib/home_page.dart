import 'package:flutter/material.dart';
import 'package:genie/contact_info.dart';
import 'package:genie/lost_found.dart';

class HomePageIcons extends StatelessWidget {
  const HomePageIcons(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.navigateTo})
      : super(key: key);

  final IconData iconData;
  final String label;
  final Widget navigateTo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => navigateTo));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
            ),
            child: Icon(
              iconData,
              color: Colors.grey,
              size: 35,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        )
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<HomePageIcons> _homePageIcons = const [
    HomePageIcons(
        iconData: Icons.contact_page_outlined,
        label: 'Airline Info',
        navigateTo: AirlineContact()),
    HomePageIcons(
        iconData: Icons.luggage_outlined,
        label: 'Lost&Found',
        navigateTo: LostFoundPage())
  ];

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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: _homePageIcons),
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
