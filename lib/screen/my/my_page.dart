import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:im_server_app/service/user.dart';
import 'package:im_server_app/user_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Uint8List avaterBuf = Uint8List(10000);
  String userName = "", userId = "";

  @override
  void didChangeDependencies() {
    String tk = Provider.of<UserState>(context).token.token;
    var userMap = JwtDecoder.decode(tk);

    Future.sync(() async {
      Uint8List imaggeBuf = Uint8List(10000);
      await Login.getAvaterUrl(userMap["avater"], context)
          .then((value) => imaggeBuf = value!);
      setState(() {
        userName = userMap["name"].toString();
        userId = userMap["id"].toString();
        avaterBuf = imaggeBuf;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, cons) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: MyPageBody(
                    avaterBuf: avaterBuf, userName: userName, userId: userId),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyPageBody extends StatelessWidget {
  const MyPageBody({
    Key? key,
    required this.avaterBuf,
    required this.userName,
    required this.userId,
  }) : super(key: key);

  final Uint8List avaterBuf;
  final String userName;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: MemoryImage(avaterBuf),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(userName), Text(userId)],
        ),
      ],
    );
  }
}
