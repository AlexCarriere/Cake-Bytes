import 'package:flutter/material.dart';

import '../business/account/login.dart';
import '../business/main/settings/defaults.dart';
import '../presentation/account/login.dart';
import '../presentation/main/home.dart';

// Class to handle all app initialization
class Initialization {
  void startup() async {
    Defaults().getDefaults();
    if(await Login().checkLoggedIn()) {
      runApp(HomePage());
    } else {
      runApp(LoginPage());
    }
  }
}
