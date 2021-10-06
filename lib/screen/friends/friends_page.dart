import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:im_server_app/module/user.dart';
import 'package:im_server_app/screen/friends/friend_model.dart';
import 'package:im_server_app/service/friends.dart';
import 'package:im_server_app/service/user.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  Map<String, String> friends = {};
  List<Widget> friendWidget = [];

  @override
  void didChangeDependencies() {
    var result = "";
    Future.sync(() async {
      await Friends.getFriendList(context).then((value) {
        result = value!;
      });
      Iterable mapList = jsonDecode(result);
      List<Friend_model> friendList = List<Friend_model>.from(
          mapList.map((json) => Friend_model.fromJson(json)));
      friendList.forEach((element) async {
        Map<String, dynamic> userModelJson = {};
        await User.getUserById(element.friendId.toString(), context)
            .then((value) => userModelJson = value!);
        UserModel user = UserModel.fromJson(userModelJson);
        Uint8List imaggeBuf = Uint8List(10000);
        await Login.getAvaterUrl(user.avater, context)
            .then((value) => imaggeBuf = value!);
        setState(() {
          friendWidget.add(
              FriendItem(friendName: user.name, friendAvaterBuffer: imaggeBuf));
        });
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => friendWidget[index],
                  childCount: friendWidget.length))
        ],
      ),
    );
  }
}

class FriendItem extends StatelessWidget {
  const FriendItem(
      {Key? key, required this.friendName, required this.friendAvaterBuffer})
      : super(key: key);
  final String friendName;
  final Uint8List friendAvaterBuffer;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundImage: MemoryImage(friendAvaterBuffer),
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              friendName,
              style: TextStyle(color: Colors.black54, fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
