import 'package:flutter/material.dart';
import 'package:genie/helper/flight_info.dart';

Map<String, Color?> statusBadgeColor = {
  'departed': Colors.red[200],
  'boarding': Colors.green[300],
  'arrived': Colors.green[300],
  'delayed': Colors.amber[300],
  'cancelled': Colors.red[200],
  'gate closed': Colors.red[200]
};

Map<String, TextStyle> textstyle = {
  'h1': TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.w600,
      color: Colors.grey[600],
      letterSpacing: 1.2),
  'h2': const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      letterSpacing: 3),
  'h2dark': TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.grey[600],
      letterSpacing: 1.6),
  'h3': const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      letterSpacing: 1.2),
};

class FlightInfoCard extends StatelessWidget {
  const FlightInfoCard({
    Key? key,
    required this.id,
    required this.carrier,
    required this.start,
    required this.destination,
    required this.estimated,
    required this.scheduled,
    required this.status,
  }) : super(key: key);

  final String id;
  final String status;
  final String carrier;
  final String start;
  final String destination;
  final String scheduled;
  final String estimated;

  @override
  Widget build(BuildContext context) {
    var startSplit = start.split(" ");
    var endSplit = destination.split(" ");
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        elevation: 0,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        clipBehavior: Clip.hardEdge,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  carrier,
                  style: textstyle['h2dark'],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                  child: Text(
                    id,
                    style: textstyle['h3'],
                  ),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            startSplit[1]
                                .substring(1, startSplit[1].length - 1),
                            style: textstyle['h1'],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            startSplit[0],
                            style: textstyle['h2'],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/icon-route.png',
                          fit: BoxFit.cover,
                        )),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            endSplit[1].substring(1, endSplit[1].length - 1),
                            style: textstyle['h1'],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            endSplit[0],
                            style: textstyle['h2'],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Scheduled',
                            style: textstyle['h2dark'],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(scheduled, style: textstyle['h3'])
                        ],
                      ),
                      Column(
                        children: [
                          Text('Estimated', style: textstyle['h2dark']),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(estimated, style: textstyle['h3'])
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding:
                  const EdgeInsets.only(right: 13, top: 5, left: 13, bottom: 5),
              decoration: BoxDecoration(
                  color: statusBadgeColor[status.toLowerCase()],
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(17))),
              child: Text(
                status,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]));
  }
}

class FlightsPage extends StatefulWidget {
  const FlightsPage({Key? key}) : super(key: key);

  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  var arrivalFlights = [];
  var departureFlights = [];
  final _textController = TextEditingController();
  var searchedString = "";

  TextStyle tabTextStyle = const TextStyle(
    fontSize: 13,
    letterSpacing: 4,
    color: Colors.grey,
  );

  void classifyFlights(List<dynamic>? allFlights) {
    arrivalFlights.clear();
    departureFlights.clear();
    for (var item in allFlights!) {
      item['start'].contains("Bengaluru")
          ? departureFlights.add(item)
          : arrivalFlights.add(item);
    }
  }

  Widget getListView(bool isDeparture) {
    var flights = isDeparture ? departureFlights : arrivalFlights;
    return ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context, index) {
          var flight = flights[index];
          return FlightInfoCard(
              id: flight['id'],
              carrier: flight['carrier'],
              start: flight['start'],
              destination: flight['to'],
              estimated: flight['estimated'],
              scheduled: flight['scheduled'],
              status: flight['status']);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: FutureBuilder(
          future: FlightDetails.getFlights(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              classifyFlights(snapshot.data);
              child = Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 16),
                    child: Text(
                      'Flights',
                      style: TextStyle(
                        color: Colors.grey,
                        letterSpacing: 1.2,
                        fontSize: 27,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextField(
                              controller: _textController,
                              style: TextStyle(color: Colors.grey[700]),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search Flight Number',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      letterSpacing: 1.05)),
                            ),
                          ),
                        ),
                        IconButton(
                            splashRadius: 20,
                            constraints: const BoxConstraints(maxHeight: 30),
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              searchedString = _textController.text.trim();
                              _textController.clear();
                              if (searchedString.isNotEmpty) {}
                            },
                            icon: const Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                  TabBar(
                    tabs: [
                      Tab(child: Text('DEPARTURES', style: tabTextStyle)),
                      Tab(child: Text('ARRIVALS', style: tabTextStyle))
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                          children: [getListView(true), getListView(false)]))
                ],
              );
            } else {
              child = const Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return child;
          },
        ),
      ),
    );
  }
}
