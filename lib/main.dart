import 'package:flutter/material.dart';

import 'package:quotz/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotz',
      // color: Colors.black,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: TextTheme(body1: TextStyle(color: Colors.white54),)
      ),
      home: HomePage(),
    );
  }
}
