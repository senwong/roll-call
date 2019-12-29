import 'package:flutter/material.dart';
import 'package:my_flutter_app/RollCall.dart';

import 'package:my_flutter_app/utils.dart';

class Detail extends StatefulWidget {
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {
  List<DetailItem> list = [];
  void getList(int rollCallId) async {
    var res = fetchPost("RollCallApi/listQueryDetailInfoByRollCallId", {
      "rollCallId": rollCallId.toString(),
    });
    if (res != null) {
      setState(() {
        list =
            List<DetailItem>.from(res.map((ele) => DetailItem.fromjson(ele)));
      });
    } else {
      throw Exception("Faild to get list");
    }
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final RollCall rollCall = ModalRoute.of(context).settings.arguments;
      getList(rollCall.rollCallId);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("点名详情"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 40,
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ]),
            child: Text(list[index].clazzName),
          );
        },
      ),
    );
  }
}

class Student {
  String beginTime;
  int detailId;
  String endTime;
  String genderName;
  bool isLeave;
  bool isTimeout;
  String phone;
  String photo;
  String remark;
  int rollCallId;
  int statusKey;
  String statusName;
  int studentId;
  String studentName;
  String studentNo;

  Student.fromJson(Map<String, dynamic> json)
      : beginTime = json['beginTime'],
        detailId = json['detailId'],
        endTime = json['endTime'],
        genderName = json['genderName'],
        isLeave = json['isLeave'],
        isTimeout = json['isTimeout'],
        phone = json['phone'],
        photo = json['photo'],
        remark = json['remark'],
        rollCallId = json['rollCallId'],
        statusKey = json['statusKey'],
        statusName = json['statusName'],
        studentId = json['studentId'],
        studentName = json['studentName'],
        studentNo = json['studentNo'];
}

class DetailItem {
  int clazzId;
  String clazzName;
  List<Student> students;
  DetailItem.fromjson(Map<String, dynamic> json)
      : clazzId = json['clazzId'],
        clazzName = json['clazzName'],
        students = List<Student>.from(
            json['students'].map((ele) => Student.fromJson(ele)).toList());
}
