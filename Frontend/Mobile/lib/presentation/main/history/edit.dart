import 'dart:async';

import 'package:flutter/material.dart';

import '../../../defines.dart';
import '../../../business/main/history/entry.dart';
import '../../../business/main/history/history.dart';

class EditPage extends StatelessWidget {
  final HistoryEntry details;
  EditPage({Key key, @required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: EditOrder(details: details),
    );
  }
}

class EditOrder extends StatefulWidget {
  final HistoryEntry details;
  EditOrder({Key key, @required this.details}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    return EditOrderState(details: details);
  }
}

class EditOrderState extends State<EditOrder> {
  final HistoryEntry details;
  final _editKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _quantityController = TextEditingController();

  EditOrderState({Key key, @required this.details}) {
    //Pre-fill the form with the old values
    _firstNameController.text = details.getFirst();
    _lastNameController.text = details.getLast();
    _quantityController.text = details.getQuantity().toString();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: _buildAppBar(),
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/wallpaper.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:_buildEditor(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: Color(ACCENT_COLOUR),
      title: Text("Edit Order"),
      centerTitle: true,
    );
  }

  Widget _buildEditor() {
    //Create the form
    return new Form(
      key: _editKey,
      child: new ListView(
        children: <Widget>[
          new Card(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(ACCENT_PINK)),   
                      ),
                      icon: Icon(Icons.person, color: Color(ACCENT_PINK)),
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Empty First Name';
                      }
                    },
                    controller: _firstNameController,
                  ),
                  margin: const EdgeInsets.fromLTRB(16.0, 10, 24.0, 10.0),
                ),
                new Container(
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(ACCENT_PINK)),   
                      ),
                      icon: Icon(Icons.people, color: Color(ACCENT_PINK)),
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Empty Last Name";
                      }
                    },
                    controller: _lastNameController,
                  ),
                  margin: const EdgeInsets.fromLTRB(16.0, 10, 24.0, 10.0),
                ),
                new Container(
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Quantity (In Dozens)',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(ACCENT_PINK)),   
                      ),
                      icon: Icon(Icons.cake, color: Color(ACCENT_PINK)),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value.isEmpty) {
                        return "Empty Quantity";
                      }
                      if(num.tryParse(value) == null) {
                        return "Numbers Only";
                      }
                      if(num.tryParse(value) <= 0) {
                        return "Minimum Quantity is 1";
                      }
                    },
                    controller: _quantityController,
                  ),
                  margin: const EdgeInsets.fromLTRB(16.0, 10.0, 24.0, 28.0),
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 8.0),
            elevation: 3.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Card(
                  child: new ListTile(
                    title: new Text(
                      "Cancel",
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  elevation: 4.0,
                  color: Color(ACCENT_COLOUR),
                  margin: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 4.0),
                ),
              ),
              new Expanded(
                child: new Card(
                  child: new ListTile(
                    title: new Text(
                      "Confirm",
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () async {
                      if(_editKey.currentState.validate()) {
                        if(await _showEditDialog()) {
                          //Pull the values from the controller
                          String first = _firstNameController.text;
                          String last =_lastNameController.text;
                          int quantity = num.tryParse(_quantityController.text);
                          //Update on the backend
                          if(await History().updateOrder(details.getOrderId(), first, last, quantity)) {
                            //Apply the changes to the entry object to reflect after popping the current view
                            details.setFirst(first);
                            details.setLast(last);
                            details.setQuantity(quantity);
                            Navigator.of(context).pop("Order successfully updated");
                          } else {
                            //If there was an error, say there was
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error: Try refreshing and try again')));
                          }
                        }
                      }
                    },
                  ),
                  elevation: 4.0,
                  color: Color(ACCENT_PINK),
                  margin: EdgeInsets.fromLTRB(8.0, 8.0, 12.0, 4.0),
                ),
              ),
            ],
          )
        ],
      )
    );
  }

  Future<bool> _showEditDialog() async {
    bool flag = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Order?'),
          content: Text('Confirm the edits for this order?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Cancel',
                style: TextStyle(
                  color: Color(ACCENT_COLOUR),
                ),
              ),
              onPressed: () {
                flag = false;
                Navigator.of(context).pop();
              }
            ),
            new FlatButton(
              child: new Text(
                'Confirm',
                style: TextStyle(
                  color: Color(ACCENT_PINK),
                ),
              ),
              onPressed: () {
                flag = true;
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
    return flag;
  }
}