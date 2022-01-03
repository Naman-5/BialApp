import 'package:flutter/material.dart';
import 'package:genie/helper/flight_info.dart';
import 'dart:convert';

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
    return Container(
      child: Text(id),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );
  }
}

class FlightsPage extends StatefulWidget {
  const FlightsPage({Key? key}) : super(key: key);

  @override
  _FlightsPageState createState() => _FlightsPageState();
}

class _FlightsPageState extends State<FlightsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FlightDetails.getFlights(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            var flights = snapshot.data;
            child = SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 40, top: 60, bottom: 50),
                    child: Text(
                      'Flights',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: flights?.length,
                      itemBuilder: (context, index) {
                        var flight = json.decode(flights![index]);
                        return FlightInfoCard(
                            id: flight['id'],
                            carrier: flight['carrier'],
                            start: flight['start'],
                            destination: flight['to'],
                            estimated: flight['estimated'],
                            scheduled: flight['scheduled'],
                            status: flight['status']);
                      })
                ],
              ),
            );
          } else {
            child = Column(children: const [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ]);
          }
          return child;
        },
      ),
    );
  }
}
