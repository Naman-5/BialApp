import 'package:http/http.dart' as http;
import 'dart:convert';

class AskBot {
  static Future sendQuery(String query) async {
    var requestBody = {
      'command': query,
    };
    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/bot?code=fX5QNX0srofVvBQlYrLWFDLzqToR9PmXcgSJjCGaMMmKPiO6J60RZA%3D%3D');
    var response = await http.post(url, body: json.encode(requestBody));
    var responseBody = json.decode(response.body);
    return responseBody;
  }
}
