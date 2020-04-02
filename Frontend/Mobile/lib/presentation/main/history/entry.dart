import 'dart:async';

import 'package:flutter/material.dart';
import '../../../business/main/history/history.dart';
import '../../../business/main/history/entry.dart';
import '../../../business/main/order/cupcake/cupcake.dart';
import '../../../presentation/main/history/edit.dart';
import '../../../presentation/main/order/cupcake/customization.dart';
import '../../../presentation/main/order/checkout.dart';
import '../../../defines.dart';

class EntryPage extends StatelessWidget {
  final HistoryEntry details;
  EntryPage({Key key, @required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/wallpaper.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Entry(details: details),
        ),
      );
    //return Entry(details: details);
  }
}

class Entry extends StatefulWidget {
  final HistoryEntry details;
  Entry({Key key, @required this.details}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntryState(details: details);
  }
}

class EntryState extends State<Entry> {
  final HistoryEntry details;
  EntryState({Key key, @required this.details});

  int _toppingOffset = 0;

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
        child:_buildDetails(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: Color(ACCENT_COLOUR),
      title: Text("Order Details"),
      centerTitle: true,
    );
  }

  Widget _buildDetails() {
    return new ListView(
      children: <Widget>[
        new Container(
          child: new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          )
        ),
        _buildBlock("Order Status", details.getStatus()),
        _buildBlock("Order Details", "${details.getOrderId()}\n${details.getTimestamp()}"),
        _buildBlock("Customer Details", details.getFullName()),
        _buildBlock("Cupcake Configuration", details.getDetailsFormatted()),
        _buildBlock("Quantity", details.getQuantityFormatted()),
        _buildBlock("Special Requests", details.getSpecial()),
        _buildPreview(),
        _buildReorderButton(),
        _buildButtons(),
      ],
      //padding: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  Widget _buildBlock(String title, String subtitle) {
    return new Card(
      child:Container(
        child: Column(
          children: <Widget>[
            new Container(
              child: new Text(
                "\n$title",
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
                child: new Text(
                "\n$subtitle",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 24.0),
            ),
          ],
        )
      ),
      margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      elevation: 3.0,
    );
  }

  Widget _buildReorderButton() {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Card(
            child: new ListTile(
              title: new Text(
                "Order Again",
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () async {
                Cupcake cake = new Cupcake(details.getBase(), details.getFrosting(), details.getTopping());
                switch(await _showOrderAgainDialog()) {
                  case 0: break;
                  case 1: _enterCheckout(cake); break;
                  case 2: _enterCustomization(cake); break;
                }
              },
            ),
            elevation: 4.0,
            color: Color(ACCENT_COLOUR),
            margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Card(
            child: new ListTile(
              title: new Text(
                "Edit Order",
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                if(details.getStatus() == "PROCESSING") {
                  _enterEdit(details);
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cancelled/completed orders cannot be edited')));
                }
              },
            ),
            elevation: 4.0,
            color: Color(ACCENT_PINK),
            margin: EdgeInsets.fromLTRB(12.0, 12.0, 8.0, 16.0),
          ),
        ),
        new Expanded(
          child: new Card(
            child: new ListTile(
              title: new Text(
                "Cancel Order",
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () async {
                if(details.getStatus() == "PROCESSING") {
                  if(await _showCancelDialog()) {
                    if(await History().updateStatus(details.getOrderId(), "Cancelled")) {
                      Navigator.of(context).pop("Order cancelled");
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error: Try again?')));
                    }
                  }
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Order is already cancelled/completed')));
                }
              },
            ),
            elevation: 4.0,
            color: Color(ACCENT_PINK),
            margin: EdgeInsets.fromLTRB(8.0, 12.0, 12.0, 16.0),
          )
        ),
      ],
    );
  }

  void _enterEdit(HistoryEntry entry) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditPage(details: entry),
      )
    );
    if(result != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("$result")));
      setState(() {});
    }
  }

  void _enterCustomization(Cupcake cupcake) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CupcakeCustomizationPage(cupcake: cupcake),
      )
    );
    if (result == "submitted") {
      Navigator.of(context).pop("submitted");
    }
  }

  void _enterCheckout(Cupcake cupcake) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CheckoutPage(cupcake: cupcake),
      )
    );
    if (result == "submitted") {
      Navigator.of(context).pop("submitted");
    }
  }

  Future<bool> _showCancelDialog() async {
    bool flag = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Order?'),
          content: Text('Do you want to cancel this order?'),
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
                'Cancel Order',
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

  Future<int> _showOrderAgainDialog() async {
    int flag = 0;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customize?'),
          content: Text('Do you want to customize the cupcake design?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Cancel',
                style: TextStyle(
                  color: Color(ACCENT_GREY),
                ),
              ),
              onPressed: () {
                flag = 0;
                Navigator.of(context).pop();
              }
            ),
            new FlatButton(
              child: new Text(
                'Checkout',
                style: TextStyle(
                  color: Color(ACCENT_COLOUR),
                ),
              ),
              onPressed: () {
                flag = 1;
                Navigator.of(context).pop();
              }
            ),
            new FlatButton(
              child: new Text(
                'Customize',
                style: TextStyle(
                  color: Color(ACCENT_PINK),
                ),
              ),
              onPressed: () {
                flag = 2;
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
    return flag;
  }

  Widget _buildPreview() {
    _toppingOffset = topping_codes.indexOf(details.getTopping());
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
                      image: AssetImage(getBasePath(details.getBase())),
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
                      image: AssetImage(getFrostingPath(details.getFrosting())),
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
                      image: AssetImage(getToppingPath(details.getTopping())),
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
}