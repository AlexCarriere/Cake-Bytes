import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../business/main/order/cupcake/cupcake.dart';
import '../../../../presentation/main/order/checkout.dart';
import '../../../../defines.dart';

class CupcakeCustomizationPage extends StatelessWidget {
  final Cupcake cupcake;
  CupcakeCustomizationPage({Key key, @required this.cupcake}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupcakeCustomization(cupcake: cupcake);
  }
}

class CupcakeCustomization extends StatefulWidget {
  final Cupcake cupcake;
  CupcakeCustomization({Key key, @required this.cupcake}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CupcakeCustomizationState(cupcake: cupcake);
  }
}

class CupcakeCustomizationState extends State<CupcakeCustomization> {
  final Cupcake cupcake;
  CupcakeCustomizationState({Key key, @required this.cupcake});

  String _baseGroupValue;
  String _frostingGroupValue;
  String _toppingGroupValue;
  
  final List<Widget> _baseOptions = [];
  final List<Widget> _frostingOptions = [];
  final List<Widget> _toppingOptions = [];

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
        child: _buildCustomizer(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: Color(ACCENT_COLOUR),
      title: Text("Customization"),
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
          title: Text('Exit Customizer?'),
          content: Text('Do you want to close the cupcake customizer?\n\nAny custom configurations made during this session will be lost!'),
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
                'Close Customizer',
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

  Widget _buildCustomizer() {
    //Set the group values to the presets
    _baseGroupValue =cupcake.getBase();
    _frostingGroupValue = cupcake.getFrosting();
    _toppingGroupValue = cupcake.getTopping();
    _toppingOffset = topping_codes.indexOf(_toppingGroupValue);

    return new ListView(
      children: <Widget>[
        _buildBases(),
        _buildFrosting(),
        _buildToppings(),
        _buildPreview(),
        _buildCheckout(),
      ],
      padding: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  void _refreshBase(String val) {
    _baseGroupValue = val;
    cupcake.setBase(val);
    setState(() {});
  }

  void _refreshFrosting(String val) {
    _frostingGroupValue = val;
    cupcake.setFrosting(val);
    setState(() {});
  }

  void _refreshTopping(String val) {
    _toppingGroupValue = val;
    cupcake.setTopping(val);
    _toppingOffset = topping_codes.indexOf(val);
    setState(() {});
  }

  Widget _buildBases() {
    //Clear out the old options
    _baseOptions.clear();
    //Add the header
    _baseOptions.add(
      new Text(
        "\nBase",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Color(ACCENT_PINK),
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _baseOptions.add(
      new Container(
        child: new Divider(
          color: Color(ACCENT_PINK),
        ),
        margin: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 4.0),
      )
    );
    //Build the radio tiles
    for(int i=0; i<base_codes.length; i++) {
      _baseOptions.add(
        new RadioListTile(
          title: Text(
            base_names[i],
            style: new TextStyle(
              color: Colors.black54,
            ),
          ),
          value: base_codes[i],
          groupValue: _baseGroupValue,
          onChanged: _refreshBase,
          activeColor: Color(ACCENT_PINK),
        )
      );
    }
    //Wrap them in a card and return
    return new Card(
      child: new Container(
        child: new Column(
          children: _baseOptions,
        ),
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
      ),
      margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 8.0),
      elevation: 3.0,
    );
  }

  Widget _buildFrosting() {
    //Clear out old options
    _frostingOptions.clear();
    //Add the header
    _frostingOptions.add(
      new Text(
        "\nFrosting",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Color(ACCENT_PINK),
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _frostingOptions.add(
      new Container(
        child: new Divider(
          color: Color(ACCENT_PINK),
        ),
        margin: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 4.0),
      )
    );
    //Build the radio tiles
    for(int i=0; i<frosting_codes.length; i++) {
      _frostingOptions.add(
        new RadioListTile(
          title: Text(
            frosting_names[i],
            style: new TextStyle(
              color: Colors.black54,
            ),
          ),
          value: frosting_codes[i],
          groupValue: _frostingGroupValue,
          onChanged: _refreshFrosting,
          activeColor: Color(ACCENT_PINK),
        )
      );
    }
    //Wrap them in a card and return
    return new Card(
      child: new Container(
        child: new Column(
          children: _frostingOptions,
        ),
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
      ),
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      elevation: 3.0,
    );
  }

  Widget _buildToppings() {
    //Clear out the old options
    _toppingOptions.clear();
    //Add the header
    _toppingOptions.add(
      new Text(
        "\nTopping",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Color(ACCENT_PINK),
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _toppingOptions.add(
      new Container(
        child: new Divider(
          color: Color(ACCENT_PINK),
        ),
        margin: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 4.0),
      )
    );
    //Build the radio tiles
    for(int i=0; i<topping_codes.length; i++) {
      _toppingOptions.add(
        new RadioListTile(
          title: Text(
            topping_names[i],
            style: new TextStyle(
              color: Colors.black54,
            ),
          ),
          value: topping_codes[i],
          groupValue: _toppingGroupValue,
          onChanged: _refreshTopping,
          activeColor: Color(ACCENT_PINK),
        )
      );
    }
    //Wrap them in a card, and return
    return new Card(
      child: new Container(
        child: new Column(
          children: _toppingOptions,
        ),
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
      ),
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      elevation: 3.0,
    );
  }

  Widget _buildPreview() {
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

  Widget _buildCheckout() {
    return new Card(
      child: new ListTile(
        title: Text(
          "Go to Checkout",
          textAlign: TextAlign.center,
          style:TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        ),
        onTap: () async {
          _enterCheckout();
        },
      ),
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 16.0),
      elevation: 4.0,
      color: Color(ACCENT_PINK),
    );
  }

  void _enterCheckout() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CheckoutPage(cupcake: cupcake),
      )
    );
    if(result == "exit") {
      Navigator.of(context).pop("exit");
    } else if (result == "submitted") {
      Navigator.of(context).pop("submitted");
    }
  }
}
