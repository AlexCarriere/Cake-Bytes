import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../../defines.dart';

class Register {
  Future<bool> addUser(String user, String pass) async {
    http.Response response = await http.post(
      Uri.encodeFull(BASE_URI + "register"),
      headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
      },
      body: json.encode({
        "username": user,
        "password": pass,
      }),
    );
    if(response.statusCode == 200) {
      if(response.body != REGISTER_FAIL) {
        return true;
      }
    }
    return false;
  }
}
