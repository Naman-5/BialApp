import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = "signInToken";

class CheckSignIn {
  static const storage = FlutterSecureStorage();
  static Future<bool> check() async {
    var storedKey = await storage.read(key: _key);
    if (storedKey == null) {
      return false;
    } else {
      return true;
    }
  }
}
