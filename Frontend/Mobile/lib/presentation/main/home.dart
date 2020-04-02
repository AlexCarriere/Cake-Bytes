import 'package:flutter/material.dart';

import '../../defines.dart';

import '../../presentation/main/history/history.dart';
import '../../presentation/main/settings/settings.dart';
import '../../presentation/main/order/cupcake/presets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    HistoryPage(),
    CupcakePresetsPage(),
    SettingsPage(),
  ];
  final List<String> _titles = [
    "History",
    "Order",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildNavBar(),
      body: _children[_currentIndex],
    );
  }

  AppBar _buildAppBar() {
    return new AppBar(
      backgroundColor: Color(ACCENT_COLOUR),
      title: Text(_titles[_currentIndex]),
      centerTitle: true,
    );
  }

  BottomNavigationBar _buildNavBar() {
    return new BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      fixedColor: Color(ACCENT_COLOUR),
      items: [
        BottomNavigationBarItem(
          icon: new Icon(
            Icons.history,
          ),
          title: Text(_titles[0]),
        ),
        BottomNavigationBarItem(
          icon: new Icon(
            Icons.cake,
          ),
          title: Text(_titles[1]),
        ),
        BottomNavigationBarItem(
          icon: new Icon(
            Icons.settings,
          ),
          title: Text(_titles[2]),
        ),
      ],
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}