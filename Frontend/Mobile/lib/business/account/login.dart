import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../defines.dart';

class Login {
  //Checks the login status of the app
  Future<bool> checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('user') ?? '';
    final token = prefs.getString('token') ?? '';

    if(login != '' && token != '') {
      stored_username = login;
      stored_token = token;
      return true;
    }

    return false;
  }

  Future<bool> checkLogin(String user, String pass) async {
    final prefs = await SharedPreferences.getInstance();

    http.Response response = await http.post(
      Uri.encodeFull(BASE_URI + "login"),
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
      if(response.body != LOGIN_FAIL) {
        stored_username = user;
        stored_token = response.body;
        await prefs.setString('user', stored_username);
        await prefs.setString('token', stored_token);
        
        return true;
      }
    }
    return false;
  }
}
