import 'package:flutter/material.dart';
import 'wheelchair.dart';
import 'medicalassist.dart';

class SpecialAssist extends StatelessWidget {
  const SpecialAssist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardImage = AssetImage("assets/images/wheelchairservice.jpeg");
    var supportingText =
        'Airport WheelChair service. Open to book a wheelchair to your desired location.';
    var suporttext =
        "Airport Medical Services. Open to get the details of emergency medical assistance of Airport.";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
                margin: EdgeInsets.all(10),
                elevation: 2.0,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WheelChairAssistance()));
                      },
                      child: Container(
                        height: 200.0,
                        child: Ink.image(
                          image: cardImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text("Wheel Chair Assistance"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      // padding: EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(supportingText),
                    ),
                  ],
                )),
            Card(
                margin: EdgeInsets.all(10),
                elevation: 2.0,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MedicalAssistPage()));
                      },
                      child: Container(
                        height: 200.0,
                        child: Ink.image(
                          image: AssetImage(
                              'assets/images/medicalAssistance.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text("Airport Medical Assistance"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      // padding: EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(suporttext),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
