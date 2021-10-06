import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:im_server_app/user_provider.dart';
import 'package:provider/provider.dart';
import 'basic.dart';

// import 'dart:html' as html;
class LoginMessage {
  String name, password;
  LoginMessage(this.name, this.password);
}

class Login {
  static Future<bool> login(
      String username, String password, BuildContext context) async {
    var body = jsonEncode({"name": username, "password": password});
    var resp = await http.post(loginUrl,
        body: body, headers: {"Content-Type": "application/json"});
    if (resp.statusCode != 200) {
      return false;
    } else {
      Provider.of<UserState>(context, listen: false)
          .updateToken(Token(resp.body));
      return true;
    }
  }

  static Future<Uint8List?> getAvaterUrl(
      String id, BuildContext context) async {
    print("avater " + id);
    final getAvaterImageUrl = Uri.parse(url + getAvaterImage + id);
    final token = Provider.of<UserState>(context, listen: false).token.token;
    final res = await http.get(getAvaterImageUrl, headers: {"token": token});
    if (res.statusCode == 200) {
      return res.bodyBytes;
    }
    return null;
  }
}

class User {
  static Future<Map<String, dynamic>?> getUserById(
      String id, BuildContext context) async {
    var body = jsonEncode({"id": id});
    final token = Provider.of<UserState>(context, listen: false).token.token;
    final resp = await http.post(Uri.parse(url + getUserByIdPath),
        body: body,
        headers: {"Content-Type": "application/json", "token": token});
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      return null;
    }
  }
}

class Register {
  static Future<String> register(String username, String password) async {
    var body = jsonEncode(
      {"name": username, "password": password},
    );
    var resp = await http.post(registerUrl,
        body: body, headers: {"Content-Type": "application/json"});
    log(resp.statusCode.toString());
    if (resp.statusCode == 200) {
      return resp.body;
    } else {
      return "";
    }
  }
}
