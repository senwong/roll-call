import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "您好呀，弗拉特尔!",
      home: MyRollCall(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => HomePage(),
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
        title: Text("Home"),
      ),
      body: Center(
        child: Container(
          margin: new EdgeInsets.only(top: 200, left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "用户名"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "密码"),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  padding: EdgeInsets.only(left: 100, right: 100),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    "登录",
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
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
