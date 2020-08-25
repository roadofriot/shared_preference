import 'package:flutter/material.dart';
import 'package:shared_preference/LoginPage.dart';

void main() {
  runApp(
     MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'SharedPreferences Demo',
      home:  LoginPage(),
    );
  }
}