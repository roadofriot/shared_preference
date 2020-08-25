import 'package:flutter/material.dart';
import 'package:shared_preference/LoginPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text("Home"),
        actions: <Widget>[
           IconButton(
              icon:  Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                     MaterialPageRoute(
                        builder: (BuildContext context) =>  LoginPage()),
                        (Route<dynamic> route) => false);
              })
        ],
      ),
      body:  Container(
        alignment: Alignment.center,
        child:  Text(
          "Welcome to flutter.!",
          style:  TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}