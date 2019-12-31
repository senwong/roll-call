import 'package:flutter/material.dart';
import 'package:my_flutter_app/RollCall.dart';

class SubText extends StatelessWidget {
  final String data;
  final TextStyle style;
  const SubText(this.data, {this.style});
  Widget build(BuildContext context) {
    return Text(
      data,
      style: subTextStyle.merge(this.style),
    );
  }
}

final TextStyle subTextStyle =
    TextStyle(fontSize: 12, color: Color.fromRGBO(102, 102, 102, 1));

class RollCallItem extends StatelessWidget {
  final RollCall rollCall;

  RollCallItem(this.rollCall);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: rollCall);
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "【${rollCall.typeName}】${rollCall.title}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: rollCall.statusKey == 0
                          ? Color.fromRGBO(255, 191, 0, 1)
                          : rollCall.statusKey == 1
                              ? Colors.blue
                              : Colors.green,
                    ),
                    padding: EdgeInsets.all(2),
                    width: 50,
                    child: Text(
                      rollCall.statusName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.only(left: 9),
                child: SubText(
                  "点名时间：${rollCall.rollCallTime}",
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 9),
                margin: EdgeInsets.only(top: 12),
                child: Row(
                  children: <Widget>[
                    SubText(
                      "应到",
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6),
                      child: SubText(
                        rollCall.rollCallNum.toString(),
                        style:
                            TextStyle(color: Color.fromRGBO(80, 148, 255, 1)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      child: SubText("已点名"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6),
                      child: SubText(
                        (rollCall.absenceNum + rollCall.normalNum).toString(),
                        style: TextStyle(color: Color.fromRGBO(255, 168, 1, 1)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      child: SubText("请假"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6),
                      child: SubText(
                        rollCall.leaveNum.toString(),
                        style: TextStyle(color: Color.fromRGBO(3, 172, 209, 1)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
