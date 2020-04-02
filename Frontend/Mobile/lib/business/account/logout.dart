import 'package:shared_preferences/shared_preferences.dart';

class Logout {
  //Clears the logged in user on the device
  void clearLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', '');
    await prefs.setString('token', '');
  }
}
