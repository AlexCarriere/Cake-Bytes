import 'package:flutter/material.dart';

import '../../defines.dart';
import '../../business/account/login.dart';
import '../../presentation/account/register.dart';
import '../../presentation/main/home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              child: LoginForm(),
              margin: const EdgeInsets.fromLTRB(8.0, 120.0, 8.0, 0.0)
            ),
            RegisterAccount(),
          ],
        ),
        resizeToAvoidBottomPadding: false,
      ),
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

class RegisterAccount extends StatefulWidget {
  @override
  RegisterAccountState createState() {
    return RegisterAccountState();
  }
}

class RegisterAccountState extends State<RegisterAccount> {
  @override
  Widget build(BuildContext context) {
    return new Align(
      child: new GestureDetector(
        onTap: () {
          _navigateAndDisplaySelection(context);
        },
        child: new Text(
          "Not Registered? Create an Account!",
          style:TextStyle(
            fontSize: 16,
            color: new Color(ACCENT_PINK),
          ),
        ),
      ),
      alignment: Alignment(0, 0.90),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()),);
    if(result != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("$result")));
    }
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
                      "Forgot Password?",
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Password reset sent')));
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
                      "Log In",
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
                        bool results = await Login().checkLogin(user, pass);
                        if(results) {
                           runApp(HomePage());
                        } else {
                           Scaffold
                          .of(context)
                          .showSnackBar(SnackBar(content: Text('Invalid username and/or password')));   
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
          )
        ],
      ),
    );
  }
}
