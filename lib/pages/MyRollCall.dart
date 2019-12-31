import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/CurrentRollCalls.dart';
import 'package:my_flutter_app/HistoricalRollCalls.dart';
import 'package:my_flutter_app/Pagination.dart';
import 'package:my_flutter_app/RollCall.dart';
import 'package:my_flutter_app/RollCallItem.dart';
import 'package:my_flutter_app/utils.dart';

class MyRollCall extends StatefulWidget {
  _MyRollCallState createState() => _MyRollCallState();
}

class _MyRollCallState extends State<MyRollCall> {
  DateTime _beginTime;
  DateTime _endTime;
  Pagination pagination =
      Pagination(current: 0, pageSize: 10, hasNextPage: true);
  int _selectedIndex = 0;
  List<Widget> tabs = [
    CurrentRollCalls(),
    HistoricalRollCalls(),
    Text("统计"),
    Text("设置")
  ];
  ScrollController scrollController = ScrollController();

  List<RollCall> rollCallList = [];

  void initState() {
    super.initState();
    getPublished();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          pagination.hasNextPage) {
        setState(() {
          pagination = Pagination(
              current: pagination.current + 1,
              pageSize: pagination.pageSize,
              hasNextPage: pagination.hasNextPage);
        });
        getPublished();
      }
    });
  }

  void getPublished() async {
    Map<String, dynamic> res =
        await fetchPost("RollCallApi/pageQueryRollCall", {
      "pageNo": pagination.current.toString(),
      "pageSize": pagination.pageSize.toString(),
    });

    if (res != null) {
      List rawList = res["rows"];
      List<RollCall> toadd =
          rawList.map((ele) => RollCall.fromJson(ele)).toList();
      setState(() {
        rollCallList.addAll(toadd);
        pagination = Pagination.fromJson(res);
      });
    } else {
      throw Exception("Faild to get access token");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的点名"),
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text(
                "当前点名",
              ),
              icon: Icon(Icons.view_list)),
          BottomNavigationBarItem(
              title: Text(
                "历史点名",
              ),
              icon: Icon(
                Icons.history,
              )),
          BottomNavigationBarItem(
              title: Text(
                "统计",
              ),
              icon: Icon(
                Icons.equalizer,
              )),
          BottomNavigationBarItem(
              title: Text("设置"),
              icon: Icon(
                Icons.settings,
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: (idx) => {
          setState(() {
            _selectedIndex = idx;
          })
        },
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
