import 'package:flutter/material.dart';

import '../../defines.dart';
import '../../business/account/register.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/wallpaper.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            createLogo(),
            new Container (
              child: RegisterForm(),
              margin: const EdgeInsets.fromLTRB(8.0, 120.0, 8.0, 0)
            ),
          ],
        ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget createLogo() {
    return new Align(
      child: new Image.asset(
        'assets/images/logo.png',
        height: 200,
        fit:BoxFit.scaleDown,
      ),
      alignment: Alignment(0, -0.75),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _loginKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _loginKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Card(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      icon: Icon(Icons.person, color: Color(ACCENT_PINK)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(ACCENT_PINK)),   
                      )
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Empty Username';
                      }
                    },
                    controller: _usernameController,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                ),
                new Container(
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      icon: Icon(Icons.lock, color: Color(ACCENT_PINK)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(ACCENT_PINK)),   
                      )
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Empty Password';
                      }
                    },
                    controller: _passwordController,
                  ),
                  margin: const EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 28.0),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
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
                      Navigator.of(context).pop("Registration cancelled");
                    },
                  ),
                  elevation: 4.0,
                  color: Color(ACCENT_COLOUR),
                  margin: EdgeInsets.fromLTRB(12.0, 12.0, 8.0, 8.0),
                ),
              ),
              new Expanded(
                child: new Card(
                  child: new ListTile(
                    title: new Text(
                      "Register",
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () async {
                      if(_loginKey.currentState.validate()) {
                        String user = _usernameController.text;
                        String pass = _passwordController.text;
                        bool results = await Register().addUser(user, pass);
                        if(results) {
                          Navigator.of(context).pop("Account registered");
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Username is taken')));
                        } 
                      }
                    },
                  ),
                  elevation: 4.0,
                  color: Color(ACCENT_PINK),
                  margin: EdgeInsets.fromLTRB(8.0, 12.0, 12.0, 8.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
