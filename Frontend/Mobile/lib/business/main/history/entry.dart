import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../defines.dart';

class HistoryEntry {
  String _orderId;
  String _first;
  String _last;
  String _timestamp;
  String _detailsBase;
  String _detailsFrosting;
  String _detailsToppings;
  String _detailsOther;
  String _status;
  int _quantity;

  static const List<String> _statusText = ["PROCESSING", "READY TO PICKUP", "COMPLETED", "CANCELLED"];
  static const List<Icon> _statusIcon = [Icon(Icons.cached), Icon(Icons.store, color: Colors.green), Icon(Icons.check, color: Colors.green), Icon(Icons.clear, color: Colors.red)];

  HistoryEntry(
    this._orderId,
    this._first,
    this._last,
    this._timestamp,
    this._detailsBase,
    this._detailsFrosting,
    this._detailsToppings,
    this._detailsOther,
    this._quantity,
    this._status,
  ) {
    //Format the date in a nicer way
    DateTime datetime = DateTime.parse(_timestamp);
    DateFormat formatter = new DateFormat("MM/dd/y - hh:mm:ss a");
    _timestamp = formatter.format(datetime);
  }

  String getOrderId() {
    return _orderId;
  }

  String getFirst() {
    return _first;
  }

  String getLast() {
    return _last;
  }

  String getFullName() {
    return "$_first $_last";
  }

  String getIdAndDatetime() {
    return "$_orderId\n$_timestamp";
  }

  int getQuantity() {
    return _quantity;
  }

  String getQuantityFormatted() {
    return "$_quantity Dozen Cupcakes";
  }

  String getStatus() {
    return _status.toUpperCase();
  }

  String getSpecial() {
    return _detailsOther == "" ? "None" : _detailsOther;
  }

  Icon getStatusIcon() {
    return _statusText.indexOf(getStatus()) < 0 ? Icon(Icons.cached) : _statusIcon[_statusText.indexOf(getStatus())];
  }

  String getTimestamp() {
    return _timestamp;
  }

  String getBase() {
    return _detailsBase;
  }

  String getFrosting() {
    return _detailsFrosting;
  }

  String getTopping() {
    return _detailsToppings;
  }

  String getDetailsFormatted() {
    String base = base_codes.indexOf(_detailsBase) < 0 ? "Unknown" : base_names[base_codes.indexOf(_detailsBase)];
    String frosting = frosting_codes.indexOf(_detailsFrosting) < 0 ? "Unknown" : frosting_names[frosting_codes.indexOf(_detailsFrosting)];
    String topping = topping_codes.indexOf(_detailsToppings) < 0 ? "Unknown" : topping_names[topping_codes.indexOf(_detailsToppings)];
    return "Base: $base\nFrosting: $frosting\nToppings: $topping";
  }

  void setFirst(String text) {
    _first = text;
  }

  void setLast(String text) {
    _last = text;
  }

  void setQuantity(int val) {
    _quantity = val;
  }
}