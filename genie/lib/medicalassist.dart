import 'package:flutter/material.dart';

class MedicalAssistPage extends StatefulWidget {
  const MedicalAssistPage({Key? key}) : super(key: key);

  @override
  _MedicalAssistPageState createState() => _MedicalAssistPageState();
}

class _MedicalAssistPageState extends State<MedicalAssistPage> {
  @override
  Widget build(BuildContext context) {
    var para = '''COVID-19 Testing Facilities - operational 24X7 

 • Auriga Research Private Limited 
    Locations – departures (west side of the terminal 
    building) & common arrival hall near gate # 11
    Contact - 9591378675 / 9591478675 / 
    9591678675

  • TATA MD Aster Lab 
     Location – Kerbside - lane 1
     Conttact  - 080-4555 3333''';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        actions: [],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Airport Medical Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Icon(Icons.location_on),
              const Text(
                  "• Aster Medical Centre – adjacent to the Terminal building east side"),
              const Text(
                  "• Aster Medical Clinic – 1st floor next to Forex counter"),
              const Icon(Icons.phone),
              const Text(
                  "• Duty Medical officer (Medical Centre) – 97397 33335"),
              const Text(
                  "• Aster Medical Clinic – 1st floor next to Forex counter"),
              const SizedBox(
                height: 10,
              ),
              Text(
                para,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
