import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../defines.dart';

class Defaults {
  void setDefaults(String first, String last, String quantity) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("default_first", first);
    prefs.setString("default_last", last);
    prefs.setString("default_quantity", quantity);
    stored_first = first;
    stored_last = last;
    stored_quantity = quantity;
  }

  void getDefaults() async {
    if(await areDefaultsSet()) {
      final prefs = await SharedPreferences.getInstance();
      stored_first = prefs.getString("default_first");
      stored_last = prefs.getString("default_last");
      stored_quantity = prefs.getString("default_quantity");
    }
  }

  Future<bool> areDefaultsSet() async {
    final prefs = await SharedPreferences.getInstance();
    final first = prefs.getString('default_first') ?? null;
    if(first == null) {
      return false;
    }
    return true;
  }

  
}