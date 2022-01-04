import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = "signInToken";

class CheckSignIn {
  final storage = const FlutterSecureStorage();
  Future<void> check() async {
    try {
      print('true side');
      MaintainPageStack.keyCheckValue = await storage.containsKey(key: _key);
    } on TypeError {
      print('false side');
      MaintainPageStack.keyCheckValue = false;
    }
  }
}

class MaintainPageStack {
  static bool keyCheck = false;
  static set keyCheckValue(keyCheck) => keyCheck;
}
