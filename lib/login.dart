import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage();
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    print(context.owner);
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: LogInForm(),
    );
  }
}

class LogInForm extends StatefulWidget {
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
  final _key = GlobalKey<FormState>();

  String _username;
  String _pwd;

  bool loading = false;

  final usernameController = TextEditingController();
  final pwdController = TextEditingController();


  void initState() {
    super.initState();

    usernameController.addListener(() {
      _username = usernameController.text;
    });
    pwdController.addListener(() {
      _pwd = pwdController.text;
    });
  }

  void dispose() {
    usernameController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  void loginRequest() async {
    loading = true;
    String url = "http://dxg.bjvtc.com/produce//v1/api/permuaa/oauth/token";
    final response = await http.post(url, body: {
      "oauth": 'true',
      'grant_type': 'password',
      'username': _username,
      'password': _pwd,
    });
    loading = false;
    if (response.statusCode == 200) {
      setToken(json.decode(response.body)['access_token']);
      Navigator.pushNamed(context, "/home");
    } else {
      throw Exception("Faild to get access token");
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Center(
        child: Container(
          width: 300,
          margin: new EdgeInsets.only(top: 200, left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "用户名"),
                validator: (value) {
                  if (value.isEmpty) return "请输入用户名！";
                  return null;
                },
                // autofocus: true,
                controller: usernameController,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: "密码"),
                validator: (value) {
                  if (value.isEmpty) return "请输入密码！";
                  return null;
                },
                controller: pwdController,
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    "登录",
                  ),
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      loginRequest();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
