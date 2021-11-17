import 'dart:convert';

import 'package:ekrut/rolesListScreen.dart';
import 'package:ekrut/services/user_service.dart';
import 'package:ekrut/rolesAddScreen.dart';
import 'package:ekrut/usersListScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    RolesListScreen(),
    UsersListScreen(),
  ];
  var _result = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Future<List<dynamic>> _getLists() async {
  //   //print(data);
  //   // if (data != null) {
  //   //   print(data);
  //   //   data.forEach((key, value) {
  //   //     print(key);
  //   //     //_result.add(value);
  //   //   });
  //   // }
  //   //print(data);
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.verified_user_rounded),
                label: 'Roles',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Users',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/add');
            },
            child: Icon(Icons.mouse),
            backgroundColor: Colors.green,
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/add': (BuildContext context) => new RolesAddScreen(),
      },
    );
  }
}
