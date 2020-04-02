import 'package:flutter/material.dart';

import '../../../business/main/settings/defaults.dart';
import '../../../defines.dart';

class SetDefaultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SetDefaults();
  }
}

class SetDefaults extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SetDefaultsState();
  }
}

class SetDefaultsState extends State<SetDefaults> {
  final _defaultsKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _quantityController = TextEditingController();

  SetDefaultsState({Key key}) {
    _firstNameController.text = stored_first;
    _lastNameController.text = stored_last;
    _quantityController.text = stored_quantity;
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
        child: _buildDefaults(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: Color(ACCENT_COLOUR),
      title: Text("Set Defaults"),
      centerTitle: true,
    );
  }


  Widget _buildDefaults() {
    //Create the form
    return new Form(
      key: _defaultsKey,
      child: new ListView(
        children: <Widget>[
          new Card(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Text(
                    "\nStored Details",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Color(ACCENT_PINK),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Container(
                  child: new Divider(
                    color: Color(ACCENT_PINK),
                  ),
                  margin: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0.0),
                ),
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
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 24.0, 10.0),
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
                      "Save Defaults",
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () async {
                      if(_defaultsKey.currentState.validate()) {
                        Defaults().setDefaults(_firstNameController.text, _lastNameController.text, _quantityController.text);
                        Navigator.of(context).pop("saved");
                      }
                    },
                  ),
                  elevation: 4.0,
                  color: Color(ACCENT_PINK),
                  margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}