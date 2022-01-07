import 'package:http/http.dart' as http;
import '../common_variables.dart';
import 'dart:convert';

class AirlineResourceRequest {
  static Future<void> getContacts() async {
    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/getairlines?code=ZfwEqUOhnCGmFAOeCPPq0KcTgaDPDAQhhHC8EpgD2lySGRE%2FRxBrYg%3D%3D');
    try {
      var response =
          await http.post(url, body: json.encode({'info': 'airlines'}));
      airlineDetails = json.decode(response.body);
    } on Exception {
      airlineDetails = [
        {
          'Title': 'Vistara',
          'LogoPath':
              'https://storageaccountbial8bd8.blob.core.windows.net/images/vistara.png',
          'Website': 'https://www.airvistara.com/in/en'
        },
        {
          'Title': 'Air-India',
          'LogoPath':
              'https://storageaccountbial8bd8.blob.core.windows.net/images/air-india-logo.png',
          'Website': 'https://www.airindia.in/index.htm'
        },
        {
          'Title': 'Indigo',
          'LogoPath':
              'https://storageaccountbial8bd8.blob.core.windows.net/images/indigo.jpeg',
          'Website': 'https://www.goindigo.in/'
        },
        {
          'Title': 'Spice-Jet',
          'LogoPath':
              'https://storageaccountbial8bd8.blob.core.windows.net/images/spice.jpeg',
          'Website': 'https://www.spicejet.com/'
        },
        {
          'Title': 'Trujet',
          'LogoPath':
              'https://storageaccountbial8bd8.blob.core.windows.net/images/trujet.jpeg',
          'Website': 'https://www.trujet.com/#/home'
        },
        {
          'Title': 'Air Asia',
          'LogoPath':
              'https://storageaccountbial8bd8.blob.core.windows.net/images/airasia.png',
          'Website': 'https://www.trujet.com/#/home'
        }
      ];
    }
  }
}
