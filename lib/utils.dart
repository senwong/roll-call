import 'dart:convert';

import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'package:http/http.dart' as http;

final storage = new FlutterSecureStorage();
void setToken(String token) async {
  print(storage);
  return await storage.write(key: 'access_token', value: token);
}

Future<String> getToken() async {
  String token = await storage.read(key: 'access_token');
  return token;
}

dynamic fetchPost(String api, Map<String, dynamic> body) async {
  String url = "http://dxg.bjvtc.com/produce//v1/api/lapp/" + api;
  body["token"] = await getToken();
  final res = await http.post(url, body: body);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}
