import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyRollCall extends StatefulWidget {
  final accessToken;

  MyRollCall(this.accessToken);

  _MyRollCallState createState() => _MyRollCallState();
}

class _MyRollCallState extends State<MyRollCall> {
  DateTime _beginTime;
  DateTime _endTime;

  List<RollCall> rollCallList = [];

  void initState() {
    super.initState();
    print("accessToken in MyRollCall initState: " + widget.accessToken);
    getPublished();
  }

  void getPublished() async {
    String url =
        "http://dxg.bjvtc.com/produce//v1/api/lapp/RollCallApi/pageQueryRollCall";
    final res = await http.post(url, body: {
      "token": widget.accessToken,
    });
    if (res.statusCode == 200) {
      List rawList = jsonDecode(res.body)['rows'];
      setState(() {
        rollCallList = rawList.map((ele) => RollCall.fromJson(ele)).toList();
      });
    } else {
      throw Exception("Faild to get access token");
    }
  }

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
      body: Column(
        children: <Widget>[
          Container(
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
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: rollCallList.length,
              itemBuilder: (BuildContext context, int index) {
                return Text('Entry ${rollCallList[index].title}');
              },
            ),
          ),
        ],
      ),
    );
  }
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

class RollCall {
  int detailId;
  int rollCallId;
  String rollCallTime;
  int statusKey;
  String statusName;
  String title;
  int typeId;
  String typeName;
  RollCall(this.detailId, this.rollCallId, this.rollCallTime, this.statusKey,
      this.statusName, this.title, this.typeId, this.typeName);

  RollCall.fromJson(Map<String, dynamic> json)
      : detailId = json['detailId'],
        rollCallId = json['rollCallId'],
        rollCallTime = json['rollCallTime'],
        statusKey = json['statusKey'],
        statusName = json['statusName'],
        title = json['title'],
        typeId = json['typeId'],
        typeName = json['typeName'];

  Map<String, dynamic> toJson() => {
        'detailId': detailId,
        'rollCallId': rollCallId,
        'rollCallTime': rollCallTime,
        'statusKey': statusKey,
        'statusName': statusName,
        'title': title,
        'typeId': typeId,
        'typeName': typeName,
      };
}
