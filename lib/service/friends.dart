import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../user_provider.dart';
import 'basic.dart';

class Friends {
  static Future<String?> getFriendList(BuildContext context) async {
    final token = Provider.of<UserState>(context).token.token;
    var resp = await http.post(getFriendListUrl, headers: {"token": token});
    if (resp.statusCode == 200) {
      print("resp" + resp.body);
      return resp.body;
    } else {
      return null;
    }
  }
}
