import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../defines.dart';

class History {
  Future<List> getHistory() async {
    http.Response response = await http.get(
      Uri.encodeFull(BASE_URI + "order/" + stored_username),
      headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        "token" : stored_token,
      },
    );
    if(response.statusCode == 200) {
      if(response.body != ORDER_GET_FAIL) {
        return json.decode(response.body);
      }
    }
    return [];
  }

  Future<bool> removeHistory(String orderId) async {
    http.Response response = await http.delete(
      Uri.encodeFull("${BASE_URI}order/$stored_username/$orderId"),
      headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        "token" : stored_token,
      },
    );
    if(response.statusCode == 200) {
      if(response.body == ORDER_DELETE_PASS) {
        return true;
      }
    }
    return false;
  }

  Future<bool> updateStatus(String orderId, String status) async {
    http.Response response = await http.post(
      Uri.encodeFull("${BASE_URI}order/$stored_username/$orderId"),
      headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        "token" : stored_token,
      },
      body: json.encode({
        "status" : status,
      }),
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateOrder(String orderId, String first, String last, int quantity) async {
    http.Response response = await http.post(
      Uri.encodeFull("${BASE_URI}order/$stored_username/$orderId"),
      headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
        "token" : stored_token,
      },
      body: json.encode({
        "first_name" : first,
        "last_name" : last,
        "amount" : quantity,
      }),
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }
}