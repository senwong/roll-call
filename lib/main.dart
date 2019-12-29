import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/MyRollCall.dart';
import 'package:my_flutter_app/detail.dart';
import 'package:my_flutter_app/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "您好呀，弗拉特尔!",
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => MyRollCall(),
        "/about": (BuildContext context) => AboutPage(),
        "/detail": (BuildContext context) => Detail(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("zh"),
      ],
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
