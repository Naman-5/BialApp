import 'package:http/http.dart' as http;
import 'dart:convert';

class FlightDetails {
  static var flights = [];
  static Future<void> getFlights() async {
    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/getairlines?code=ZfwEqUOhnCGmFAOeCPPq0KcTgaDPDAQhhHC8EpgD2lySGRE%2FRxBrYg%3D%3D');
    try {
      var response =
          await http.post(url, body: json.encode({'info': 'flights'}));
      flights = json.decode(response.body);
    } on Exception {
      flights = [
        {
          'id': 'not-available',
          'carrier': 'NA',
          'status': 'NA',
          'start': 'NA',
          'to': 'NA',
          'scheduled': 'NA',
          'estimated': 'NA'
        }
      ];
    }
  }
}
