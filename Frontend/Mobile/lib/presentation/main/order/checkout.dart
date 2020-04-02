import 'dart:async';

import 'package:flutter/material.dart';

import '../../../business/main/order/cupcake/cupcake.dart';
import '../../../business/main/order/order.dart';
import '../../../business/main/settings/defaults.dart';
import '../../../defines.dart';

class CheckoutPage extends StatelessWidget {
  final Cupcake cupcake;
  CheckoutPage({Key key, @required this.cupcake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkout(cupcake: cupcake);
  }
}

class Checkout extends StatefulWidget {
  final Cupcake cupcake;
  Checkout({Key key, @required this.cupcake}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CheckoutState(cupcake: cupcake);
  }
}

class CheckoutState extends State<Checkout> {
  final Cupcake cupcake;
  final _checkoutKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _specialController = TextEditingController();
  int _toppingOffset = 0;

  CheckoutState({Key key, @required this.cupcake}) {
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
        child:_buildCheckout(),
      ),
    );
  }
  
  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: Color(ACCENT_COLOUR),
      title: Text("Checkout"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () async {
            if(await _showExitDialog()) {
              Navigator.of(context).pop("exit");
            }
          },
        ),
      ],
    );
  }

  Future<bool> _showExitDialog() async {
    bool flag = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Close Checkout?'),
          content: Text('Do you want to close the cupcake checkout?\n\nAny custom configurations made during this session will be lost!'),
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
                'Close Checkout',
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

  Widget _buildCheckout() {
    return new Form(
      key: _checkoutKey,
      child: new ListView(
        children: <Widget>[
          new Card(
            child: new Column(
              children: <Widget>[
                new Text(
                  "\nCheckout Details",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Color(ACCENT_PINK),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Container(
                  child: new Divider(
                    color: Color(ACCENT_PINK),
                  ),
                  margin: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 4.0),
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
                      labelText: 'Special Requests (Optional)',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(ACCENT_PINK)),   
                      ),
                      icon: Icon(Icons.tune, color: Color(ACCENT_PINK)),
                    ),
                    controller: _specialController,
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
          _buildPreview(),
          new Card(
            child: new ListTile(
              title: Text(
                "Submit Order",
                textAlign: TextAlign.center,
                style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              ),
              onTap: () async {
                if(_checkoutKey.currentState.validate()) {
                  if(await _showConfirmDialog()) {
                    if(await Order().addOrder(
                      _firstNameController.text,
                      _lastNameController.text,
                      cupcake.getBase(),
                      cupcake.getFrosting(),
                      cupcake.getTopping(),
                      _specialController.text,
                      num.tryParse(_quantityController.text),
                    )) {
                      Navigator.of(context).pop("submitted");
                    }
                  }
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 16.0),
            elevation: 4.0,
            color: Color(ACCENT_PINK),
          ),
        ],
      )
    );
  }

  Widget _buildPreview() {
    _toppingOffset = topping_codes.indexOf(cupcake.getTopping());
    return new Card(
      child: new Column(
        children: <Widget>[
          new Center(
            child: Text(
              "\nCupcake Preview",
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Color(ACCENT_PINK),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          new Container(
            child: new Divider(
              color: Color(ACCENT_PINK),
            ),
            margin: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 4.0),
          ),        
          new Container(
            child: new Stack(
              children: <Widget>[
                new Center(
                  child: FractionalTranslation(
                    child: Image(
                      image: AssetImage(getBasePath(cupcake.getBase())),
                      height: 100,
                    ),
                    translation: Offset(
                      base_offset[0],
                      base_offset[1]
                    ),
                  ),
                ),
                new Center(
                  child: FractionalTranslation(
                    child: Image(
                      image: AssetImage(getFrostingPath(cupcake.getFrosting())),
                      height: 100,
                    ),
                    translation: Offset(
                      frosting_offset[0],
                      frosting_offset[1]
                    ),
                  ),
                ),
                new Center(
                  child: FractionalTranslation(
                    child: Image(
                      image: AssetImage(getToppingPath(cupcake.getTopping())),
                      height: 75,
                    ),
                    translation: Offset(
                      topping_offsets[_toppingOffset][0],
                      topping_offsets[_toppingOffset][1]
                    ),
                  ),
                ),
              ],
            ),
            height: 225,
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      elevation: 3.0,
    );
  }

  Future<bool> _showConfirmDialog() async {
    bool flag = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submit Order?'),
          content: Text('Payment will be processed in-store on pickup.'),
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
                'Submit Order',
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