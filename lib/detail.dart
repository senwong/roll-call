import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/RollCall.dart';
import 'package:my_flutter_app/RollCallItem.dart';

import 'package:my_flutter_app/utils.dart';
import 'RollCallDetail.dart';

class Detail extends StatefulWidget {
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {
  List<RollCallDetail> list = [];
  List<RollCallWithExpand> listWithExpand = [];
  void getList(int rollCallId) async {
    var res = await fetchPost("RollCallApi/listQueryDetailInfoByRollCallId", {
      "rollCallId": rollCallId.toString(),
    });
    if (!mounted) return;
    if (res != null) {
      print("response: " + rollCallId.toString() + "----\n" + jsonEncode(res));
      setState(() {
        list = List<RollCallDetail>.from(
            res.map((ele) => RollCallDetail.fromJson(ele)));
        listWithExpand = List.from(list.map((rollCallDetail) =>
            RollCallWithExpand(
                isExpanded: false, rollCallDetail: rollCallDetail)));
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
      body: SingleChildScrollView(
        child: _buildPanel(),
      ),
      // body: ListView.builder(
      //   padding: EdgeInsets.all(12),
      //   itemCount: list.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     print(list[index].toJson());
      //     return Container(
      //       height: 40,
      //       margin: EdgeInsets.only(top: 12),
      //       padding: EdgeInsets.all(12),
      //       decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //         BoxShadow(
      //           color: Color.fromRGBO(0, 0, 0, 0.1),
      //           blurRadius: 5,
      //           spreadRadius: 2,
      //         ),
      //       ]),
      //       child: Text(list[index].clazzName),
      //     );
      //   },
      // ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int panelIndex, bool isExpanded) {
        setState(() {
          listWithExpand[panelIndex].isExpanded = !isExpanded;
        });
      },
      children: List<ExpansionPanel>.from(
          listWithExpand.map((rollCallDetailWidthExpand) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            String title = rollCallDetailWidthExpand.rollCallDetail.clazzName;
            title = title != '' ? title : "默认班级名称";
            return ListTile(
              title: Text(title),
            );
          },
          body: Column(
            children: List<Widget>.from(rollCallDetailWidthExpand
                .rollCallDetail.students
                .map((student) {
              String studentName =
                  student.studentName != '' ? student.studentName : "默认学生姓名";
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        spreadRadius: 5,
                      ),
                    ]),
                child: Text(studentName),
                 
              );
            })),
          ),
          isExpanded: rollCallDetailWidthExpand.isExpanded,
          canTapOnHeader: true,
        );
      })),
    );
  }
}

class RollCallWithExpand {
  RollCallWithExpand({
    this.isExpanded = false,
    this.rollCallDetail,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  RollCallDetail rollCallDetail;
}
