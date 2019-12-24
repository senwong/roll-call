import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
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

class Token {
  final String accessToken;
  Token({this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(accessToken: json['access_token']);
  }
}

class LogInFormState extends State<LogInForm> {
  final _key = GlobalKey<FormState>();

  String _username;
  String _pwd;

  bool loading = false;

  final usernameController = TextEditingController();
  final pwdController = TextEditingController();

  Future<Token> token;

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

  Future<Token> loginRequest() async {
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
      print(json.decode(response.body));
      return Token.fromJson(json.decode(response.body));
    } else {
      throw Exception("Faild to get access token");
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Center(
        child: Container(
          margin: new EdgeInsets.only(top: 200, left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "用户名"),
                validator: (value) {
                  if (value.isEmpty) return "请输入用户名！";
                  return null;
                },
                autofocus: true,
                controller: usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "密码"),
                validator: (value) {
                  if (value.isEmpty) return "请输入密码！";
                  return null;
                },
                controller: pwdController,
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
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      token = loginRequest();
                      Navigator.pushNamed(context, "/home");
                    }
                  },
                ),
              ),
              loading
                  ? FutureBuilder<Token>(
                      future: token,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.accessToken);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }

                        return CircularProgressIndicator();
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
