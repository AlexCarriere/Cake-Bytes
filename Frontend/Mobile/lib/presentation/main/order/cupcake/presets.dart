import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../business/main/order/cupcake/cupcake.dart';
import '../../../../presentation/main/order/checkout.dart';
import '../../../../presentation/main/order/cupcake/customization.dart';
import '../../../../defines.dart';

class CupcakePresetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupcakePresets();
  }
}

class CupcakePresets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CupcakePresetsState();
  }
}

class CupcakePresetsState extends State<CupcakePresets> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/wallpaper.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: _buildPresets(),
    );
  }

  Future<int> _showCheckoutDialog() async {
    int flag = 0;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customize?'),
          content: Text('Do you want to customize the cupcake preset?'),
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

  Widget _buildPresets() {
    return new ListView(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Card(
                  child: new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            Text("\n\n\n\n\n\n"),
                            FractionalTranslation(
                              child: Image(
                                image: AssetImage("assets/images/cupcake_builder/base/chocolate_base.png"),
                                height: 50,
                              ),
                              translation: Offset(0.1, 1.0),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/frosting/vanilla_frosting.png"),
                                height: 50,
                              ),
                              translation: Offset(0.0, 0.55),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/topping/cherry.png"),
                                height: 30,
                              ),
                              translation: Offset(1.25, 0.45),
                            ),
                          ],
                        ),
                        new Center(
                          child: Text(
                            "Chocolate Base\nVanilla Frosting\nCherries\n",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      Cupcake cake = new Cupcake(base_codes[0], frosting_codes[3], topping_codes[2]);
                      _presetPressed(cake);
                    },
                  ),
                  elevation: 3.0,
                ),
                margin: EdgeInsets.fromLTRB(8.0, 12.0, 2.0, 0.0),
              ),
            ),
            new Expanded(
              child: new Container(
                child: new Card(
                  child: new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            Text("\n\n\n\n\n\n"),
                            FractionalTranslation(
                              child: Image(
                                image: AssetImage("assets/images/cupcake_builder/base/vanilla_base.png"),
                                height: 50,
                              ),
                              translation: Offset(0.1, 1.0),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/frosting/mint_frosting.png"),
                                height: 50,
                              ),
                              translation: Offset(0.0, 0.55),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/topping/rainbow_sprinkle.png"),
                                height: 30,
                              ),
                              translation: Offset(0.25, 0.65),
                            ),
                          ],
                        ),
                        new Center(
                          child: Text(
                            "Vanilla Base\nMint Frosting\nRainbow Sprinkles\n",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      Cupcake cake = new Cupcake(base_codes[2], frosting_codes[2], topping_codes[7]);
                      _presetPressed(cake);
                    },
                  ),
                  elevation: 3.0,
                ),
                margin:EdgeInsets.fromLTRB(2.0, 12.0, 8.0, 0.0),
              ),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Card(
                  child: new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            Text("\n\n\n\n\n\n"),
                            FractionalTranslation(
                              child: Image(
                                image: AssetImage("assets/images/cupcake_builder/base/redvelvet_base.png"),
                                height: 50,
                              ),
                              translation: Offset(0.1, 1.0),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/frosting/vanilla_frosting.png"),
                                height: 50,
                              ),
                              translation: Offset(0.0, 0.55),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/topping/pocky.png"),
                                height: 30,
                              ),
                              translation: Offset(1.25, 0.45),
                            ),
                          ],
                        ),
                        new Center(
                          child: Text(
                            "Red Velvet Base\nVanilla Frosting\nPocky\n",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      Cupcake cake = new Cupcake(base_codes[1], frosting_codes[3], topping_codes[6]);
                      _presetPressed(cake);
                    },
                  ),
                  elevation: 3.0,
                ),
                margin:EdgeInsets.fromLTRB(8.0, 4.0, 2.0, 0.0),
              )
            ),
            new Expanded(
              child: new Container(
                child: new Card(
                  child: new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            Text("\n\n\n\n\n\n"),
                            FractionalTranslation(
                              child: Image(
                                image: AssetImage("assets/images/cupcake_builder/base/vanilla_base.png"),
                                height: 50,
                              ),
                              translation: Offset(0.1, 1.0),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/frosting/chocolate_frosting.png"),
                                height: 50,
                              ),
                              translation: Offset(0.0, 0.55),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/topping/strawberry.png"),
                                height: 30,
                              ),
                              translation: Offset(0.80, 0.50),
                            ),
                          ],
                        ),
                        new Center(
                          child: Text(
                            "Vanilla Base\nChocolate Frosting\nStrawberry\n",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      Cupcake cake = new Cupcake(base_codes[2], frosting_codes[0], topping_codes[9]);
                      _presetPressed(cake);
                    },
                  ),
                  elevation: 3.0,
                ),
                margin: EdgeInsets.fromLTRB(2.0, 4.0, 8.0, 0.0),
              ),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Card(
                  child: new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            Text("\n\n\n\n\n\n"),
                            FractionalTranslation(
                              child: Image(
                                image: AssetImage("assets/images/cupcake_builder/base/vanilla_base.png"),
                                height: 50,
                              ),
                              translation: Offset(0.1, 1.0),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/frosting/vanilla_frosting.png"),
                                height: 50,
                              ),
                              translation: Offset(0.0, 0.55),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/topping/star_sprinkle.png"),
                                height: 30,
                              ),
                              translation: Offset(0.5, 0.65),
                            ),
                          ],
                        ),
                        new Center(
                          child: Text(
                            "Vanilla Base\nVanilla Frosting\nStar Sprinkles\n",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      Cupcake cake = new Cupcake(base_codes[2], frosting_codes[3], topping_codes[8]);
                      _presetPressed(cake);
                    },
                  ),
                  elevation: 3.0,
                ),
                margin:EdgeInsets.fromLTRB(8.0, 4.0, 2.0, 0.0),
              ),
            ),
            new Expanded(
              child: new Container(
                child: new Card(
                  child: new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            Text("\n\n\n\n\n\n"),
                            FractionalTranslation(
                              child: Image(
                                image: AssetImage("assets/images/cupcake_builder/base/redvelvet_base.png"),
                                height: 50,
                              ),
                              translation: Offset(0.1, 1.0),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/frosting/chocolate_frosting.png"),
                                height: 50,
                              ),
                              translation: Offset(0.0, 0.55),
                            ),
                            FractionalTranslation(
                              child: Image(
                              image: AssetImage("assets/images/cupcake_builder/topping/eatMe.png"),
                                height: 30,
                              ),
                              translation: Offset(0.75, 0.75),
                            ),
                          ],
                        ),
                        new Center(
                          child: Text(
                            "Red Velvet Base\nChocolate Frosting\n\"Eat Me\" Words\n",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () async {
                      Cupcake cake = new Cupcake(base_codes[1], frosting_codes[0], topping_codes[3]);
                      _presetPressed(cake);
                    },
                  ),
                  elevation: 3.0,
                ),
                margin: EdgeInsets.fromLTRB(2.0, 4.0, 8.0, 0.0),
              ),
            ),
          ],
        ),
        new Card(
          child: new ListTile(
            title: Text(
              "Start From Scratch",
              textAlign: TextAlign.center,
              style:TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            ),
            onTap: () async {
              Cupcake cake = new Cupcake("chocolate", "chocolate", "none");
              _enterCustomization(cake);
            },
          ),
          margin: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 14.0),
          elevation: 4.0,
          color: Color(ACCENT_PINK),
        ),
      ],
    );
  }

  void _enterCustomization(Cupcake cupcake) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CupcakeCustomizationPage(cupcake: cupcake),
      )
    );
    if(result == "submitted") {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cupcake order created')));
    }
  }

  void _enterCheckout(Cupcake cupcake) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CheckoutPage(cupcake: cupcake),
      )
    );
    if(result == "submitted") {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cupcake order created')));
    }
  }

  void _presetPressed(Cupcake cake) async {
    int flag = await _showCheckoutDialog();
    switch(flag) {
      case 0: break;
      case 1: _enterCheckout(cake); break;
      case 2: _enterCustomization(cake); break;
    }
  }
}
