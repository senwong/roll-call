import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/MyRollCall.dart';
import 'package:my_flutter_app/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String accessToken;

  void setAccessToken(String token) {
    accessToken = token;
    print('accessToken: ' + token);
  }

  Widget build(BuildContext context) {
        return MaterialApp(
      title: "您好呀，弗拉特尔!",
      home: LoginPage(setAccessToken),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => MyRollCall(accessToken),
        "/about": (BuildContext context) => AboutPage(),
      },
    );
  }
}

class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
    );
  }
}
