import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:im_server_app/module/user.dart';
import 'package:im_server_app/screen/friends/friends_page.dart';
import 'package:im_server_app/screen/message/message_page.dart';
import 'package:im_server_app/module/message_data.dart';
import 'package:im_server_app/screen/my/my_page.dart';
import 'package:im_server_app/service/message.dart';
import 'package:im_server_app/service/user.dart';
import 'package:im_server_app/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../message_provider.dart';
import '../../websocket_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [MessagePage(), FriendsPage(), MyPage()];
  var pagesIndex = 0;
  late Map<UserModel, List<MessageData>> allMessagesMap = {};
  late List<Map<UserModel, MessageData>> newMessageList = [];

  // @override
  // void activate() {
  //   // TODO: implement activate
  //   super.activate();
  // }

  @override
  void didChangeDependencies() {
    print("main active");
    WebSocketChannel channel = Websocket.websocketConnect(context);
    channel.sink.add("/register_online_user");
    Provider.of<WebsocketChannelState>(context, listen: false)
        .setChannel(channel);

    Provider.of<WebsocketChannelState>(context).channel.stream.listen((event) {
      if (event[0] == "{") {
        final messageData = MessageData.fromJson(json.decode(event));
        UserModel userModel;
        print(messageData.msgFrom);
        User.getUserById(messageData.msgFrom, context).then((value) => {
              if (value != null)
                {
                  userModel = UserModel.fromJson(value),
                  Future.sync(() {
                    Provider.of<MessageState>(context, listen: false)
                        .addAllMessageMap(userModel, messageData);
                    Provider.of<MessageState>(context, listen: false)
                        .addNewMessage(userModel, messageData);
                  }),
                }
            });
      }
    });
    super.didChangeDependencies();
    // super.activate();
  }

  @override
  void deactivate() {
    Provider.of<MessageState>(context).saveAllMessageToSql();
    // Provider.of<MessageState>(context).saveNewMessageToSql();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();

    if (Provider.of<UserState>(context, listen: false).getToken().token == "") {
      Navigator.pushNamed(context, "/not_login");
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pagesIndex],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_left_rounded,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pagesIndex = index;
          });
          print("main" + pagesIndex.toString());
        },
        currentIndex: pagesIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.messenger),
              backgroundColor: Colors.white54,
              label: "Messagers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              backgroundColor: Colors.white54,
              label: "Friends"),
          BottomNavigationBarItem(
              // icon: CircleAvatar(
              //   backgroundImage: AssetImage("assert/icons/chat.svg"),
              // ),

              icon: Icon(Icons.person),
              backgroundColor: Colors.white54,
              label: "My")
        ],
      ),
    );
  }
}
