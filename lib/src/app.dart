import 'package:flutter/material.dart';
import '../screens/home.dart';

// ignore: use_key_in_widget_constructors
class App extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      home: Home(),
    );
  }
}
