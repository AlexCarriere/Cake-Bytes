import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../defines.dart';

class Order {
  Future<bool> addOrder(String first, String last, String base, String frosting, String topping, String special, int quantity) async {
    http.Response response = await http.post(
      "$BASE_URI/order/$stored_username",
      headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        "token" : stored_token,
      },
      body: json.encode({
        "first_name" : first,
        "last_name" : last,
        "detail" : {
          "base" : base,
          "icing" : frosting,
          "deco" : topping,
          "other_request" : special,
        },
        "amount": quantity,
      }),
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}