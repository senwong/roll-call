import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "您好呀，弗拉特尔!",
      home: MyRollCall(),
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
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ]
        ),
        child:       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DatePickerDiy("开始时间", (val) {
            setState(() {
              _beginTime = val.toLocal();
            });
          }),
          Text("至", style: TextStyle(fontSize: 24),),
          DatePickerDiy("结束时间", (val) {
            setState(() {
              _endTime = val.toLocal();
            });
          }),
          Icon(Icons.calendar_today),
        ],
      ),
      )
      

    );
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

class RandomWordsState extends State<RandomWords> {
  final _biggerFontSize = const TextStyle(fontSize: 18.0);
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Startup Name Generator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> titles = _saved.map((WordPair pair) {
        return ListTile(title: Text(pair.asPascalCase, style: _biggerFontSize));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: titles).toList();
      return Scaffold(
        appBar: AppBar(title: Text("Saved Words")),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFontSize,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  RandomWordsState createState() => RandomWordsState();
}
