import 'package:http/http.dart' as http;
import 'dart:convert';


class ShopDetails {
  static var shops = [];
  // static Map<String, dynamic> shops = Map();
  static Future<void> getShops() async {
    var url = Uri.parse(
        'https://bialapp.azurewebsites.net/api/fetchItemData?code=ZnhxeZ0MLvWwLElfznNNaDTiskyYroMQ8H3Hcs1UsOkEayqNZujaKQ==');
    try {
      var response =
          await http.post(url, body: json.encode({'info': 'shops'}), headers: {"Access-Control-Allow-Origin": "POST,GET,DELETE,PUT,OPTIONS"});
      shops = json.decode(response.body);
    } on Exception {
      shops = [
        {
          "id": 'NA',
          "location": "NA",
          "Contact Details": {
              "phone": "NA",
              "email": "NA"
          },
          "image": "NA",
        }];
    }
  }
}