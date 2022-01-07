import 'package:http/http.dart' as http;
import 'dart:convert';

class FlightDetails {
  static var flights = [];
  static Future<List<dynamic>> getFlights() async {
    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/getairlines?code=ZfwEqUOhnCGmFAOeCPPq0KcTgaDPDAQhhHC8EpgD2lySGRE%2FRxBrYg%3D%3D');
    try {
      var response =
          await http.post(url, body: json.encode({'info': 'flights'}));
      flights = await json.decode(response.body);
      return flights;
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
      return [];
    }
  }
}
