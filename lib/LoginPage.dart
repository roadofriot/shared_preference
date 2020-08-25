import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preference/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() =>  _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username =  TextEditingController();
  TextEditingController password =  TextEditingController();

  bool checkValue = false;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white12,
      ),
      body:  SingleChildScrollView(
        child: _body(),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _body() {
    return  Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           Container(
            margin: EdgeInsets.all(30.0),
            child:  Image.asset(
              "assets/images/flutter_icon.png",
              height: 100.0,
            ),
          ),
           TextField(
            controller: username,
            decoration: InputDecoration(
                hintText: "username",
                hintStyle:  TextStyle(color: Colors.grey.withOpacity(0.3))),
          ),
           TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "password",
                  hintStyle:
                   TextStyle(color: Colors.grey.withOpacity(0.3)))),
           CheckboxListTile(
            value: checkValue,
            onChanged: _onChanged,
            title:  Text("Remember me"),
            controlAffinity: ListTileControlAffinity.leading,
          ),
           Container(
            decoration:
             BoxDecoration(border: Border.all(color: Colors.black)),
            child:  ListTile(
              title:  Text(
                "Login",
                textAlign: TextAlign.center,
              ),
              onTap: _navigator,
            ),
          )
        ],
      ),
    );
  }

  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", username.text);
      sharedPreferences.setString("password", password.text);
      sharedPreferences.commit();
      getCredential();
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          username.text = sharedPreferences.getString("username");
          password.text = sharedPreferences.getString("password");
        } else {
          username.clear();
          password.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _navigator() {
    if (username.text.length != 0 || password.text.length != 0) {
      Navigator.of(context).pushAndRemoveUntil(
           MaterialPageRoute(
              builder: (BuildContext context) =>  HomeScreen()),
              (Route<dynamic> route) => false);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          child:  CupertinoAlertDialog(
            content:  Text(
              "username or password \ncan't be empty",
              style:  TextStyle(fontSize: 16.0),
            ),
            actions: <Widget>[
               FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:  Text("OK"))
            ],
          ));
    }
  }
}