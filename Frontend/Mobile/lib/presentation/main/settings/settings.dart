import 'package:flutter/material.dart';

import '../../../defines.dart';
import '../../../business/account/logout.dart';
import '../../../presentation/account/login.dart';
import '../../../presentation/main/settings/defaults.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Settings();
  }
}

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/wallpaper.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildOptions(),
      ),
    );
  }

  Widget _buildOptions() {
    return new ListView(
      children: <Widget>[
        new Card(
          child: new ListTile(
            title: Text(
              "Set Defaults",
              textAlign: TextAlign.center,
              style:TextStyle(
                //color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            ),
            onTap: () async {
              _enterDefaults();
            },
          ),
          margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
          elevation: 4.0,
        ),
        new Card(
          child: new ListTile(
            title: Text(
              "Log Out",
              textAlign: TextAlign.center,
              style:TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            ),
            onTap: () async {
              _showLogoutDialog();
            },
          ),
          margin: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
          elevation: 4.0,
          color: Color(ACCENT_PINK),
        ),
      ],
      padding: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  void _enterDefaults() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SetDefaultsPage(),
      )
    );
    if(result == "saved") {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("Default settings saved")));
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out?'),
          content: Text('Do you want to log out?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Cancel',
                style: TextStyle(
                  color: Color(ACCENT_COLOUR),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                'Log Out',
                style: TextStyle(
                  color: Color(ACCENT_PINK),
                ),
              ),
              onPressed: () {
                Logout().clearLogin();
                runApp(LoginPage());
              }
            ),
          ],
        );
      }
    );
  }
}
