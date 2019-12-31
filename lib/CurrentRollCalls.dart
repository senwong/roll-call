import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/Pagination.dart';
import 'package:my_flutter_app/RollCall.dart';
import 'package:my_flutter_app/RollCallItem.dart';
import 'package:my_flutter_app/utils.dart';

class CurrentRollCalls extends StatefulWidget {
  CurrentRollCallsState createState() => CurrentRollCallsState();
}

class CurrentRollCallsState extends State<CurrentRollCalls> {
  DateTime _beginTime;
  DateTime _endTime;
  bool _loading = false;
  Pagination pagination =
      Pagination(current: 0, pageSize: 10, hasNextPage: true);

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
    setState(() {
      _loading = true;
    });
    Map<String, dynamic> res =
        await fetchPost("RollCallApi/pageQueryRollCall", {
      "pageNo": pagination.current.toString(),
      "pageSize": pagination.pageSize.toString(),
      "statusKeys": "0,1",
    });
    if (res != null) {
      List rawList = res["rows"];
      List<RollCall> toadd =
          rawList.map((ele) => RollCall.fromJson(ele)).toList();
      if (!mounted) return;
      setState(() {
        rollCallList.addAll(toadd);
        pagination = Pagination.fromJson(res);
      });
    } else {
      throw Exception("Faild to get access token");
    }
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Column(
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
          child: _loading
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: rollCallList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RollCallItem(rollCallList[index]);
                  },
                  controller: scrollController,
                ),
        ),
      ],
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
