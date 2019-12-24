import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_flutter_app/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "您好呀，弗拉特尔!",
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => MyRollCall(),
        "/about": (BuildContext context) => AboutPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("首页"),
      ),
      body: Text("首页"),
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

class _MyRollCallState extends State<MyRollCall> {
  DateTime _beginTime;
  DateTime _endTime;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的点名"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
            )
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DatePickerDiy("开始时间", (val) {
                setState(() {
                  _beginTime = val.toLocal();
                });
              }),
              Text(
                "至",
                style: TextStyle(fontSize: 24),
              ),
              DatePickerDiy("结束时间", (val) {
                setState(() {
                  _endTime = val.toLocal();
                });
              }),
              Icon(Icons.calendar_today),
            ],
          ),
        ));
  }
}

class MyRollCall extends StatefulWidget {
  _MyRollCallState createState() => _MyRollCallState();
}

class DatePickerDiy extends StatefulWidget {
  DatePickerDiy(this._name, this._onChange);
  final String _name;
  final Function _onChange;

  _DatePickerDiyState createState() => _DatePickerDiyState();
}

class _DatePickerDiyState extends State<DatePickerDiy> {
  DateTime _value;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future<DateTime> future = showDatePicker(
          lastDate: DateTime(9000),
          firstDate: DateTime(1900),
          initialDate: DateTime.now(),
          context: context,
          locale: Localizations.localeOf(context),
        );
        future.then((date) {
          setState(() {
            _value = date.toLocal();
          });
          widget._onChange(date);
        });
      },
      child: Text(
        _value == null
            ? widget._name
            : _value.year.toString() +
                '-' +
                _value.month.toString() +
                '-' +
                _value.day.toString(),
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
