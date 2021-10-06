import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:im_server_app/message_provider.dart';
import 'package:im_server_app/module/user.dart';
import 'package:im_server_app/screen/message/message_detail.dart';
import 'package:im_server_app/module/message_data.dart';
import 'package:im_server_app/service/user.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key})
      // : channel = webChannel,
      : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  List<Map<UserModel, MessageData>> newMessageList = [];
  List<Widget> newMessageListWidget = [];

// @override
//   void activate() {
//     // TODO: implement activate
//     super.activate();
//   }
  @override
  void didChangeDependencies() {
    print("message page change depen");
    final List<Map<UserModel, MessageData>> list =
        Provider.of<MessageState>(context).newMessageList;
    setState(() {
      newMessageListWidget = [];
    });
    list.forEach((map) {
      map.forEach((key, value) {
        Future.sync(() async {
          await Login.getAvaterUrl(key.avater, context).then((bytes) {
            setState(() {
              newMessageListWidget.add(MessageItem(
                lastTime: DateTime.parse(value.arriveTime),
                desnationId: key.id.toString(),
                destinationName: key.name,
                lastMessage: value.msgContent,
                avaterPath: bytes!,
              ));
            });
          });
        });
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.white24,
        child: AnimatedBuilder(
            animation: MessageState(),
            builder: (context, _) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return newMessageListWidget[index];

                            // return MessageItem(
                            //     avaterPath: avaterpath!,
                            //     desnationId: desnationId,
                            //     destinationName: destinationName,
                            //     // lastTime: DateTime.parse(lastTime),
                            //     lastTime: DateTime.now(),
                            //     lastMessage: lastMessage);
                          },
                          childCount: newMessageListWidget.length,
                        ),
                      )
                    ],
                  );
                },
              );
            }),
      ),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MessageItem extends StatefulWidget {
  MessageItem(
      {Key? key,
      required this.avaterPath,
      required this.desnationId,
      required this.destinationName,
      required this.lastTime,
      required this.lastMessage})
      : super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();

  String destinationName, lastMessage, desnationId;
  DateTime lastTime;
  Uint8List avaterPath;
}

class _MessageItemState extends State<MessageItem> {
  var showMessageItem = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentTime = DateTime.now();
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constrants) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessageDetail(
                              destinationId: widget.desnationId,
                              avaterByteList: widget.avaterPath,
                              friendName: widget.destinationName,
                            )));
              },
              onHorizontalDragStart: (event) {
                setState(() {
                  showMessageItem = true;
                });
              },
              child: Container(
                width: constrants.maxWidth * 0.5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                // color: Colors.black45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    CircleAvatar(
                      backgroundImage: MemoryImage(widget.avaterPath),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.destinationName,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(widget.lastMessage,
                            style: TextStyle(fontSize: 20, color: Colors.black))
                      ],
                    ),
                    Spacer(
                      flex: 4,
                    ),
                    Text(widget.lastTime.subtract(Duration()).toString()),
                    Spacer(
                      flex: 1,
                    ),
                    showMessageItem ? MessageOperator() : Container()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MessageOperator extends StatelessWidget {
  const MessageOperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [TextButton(onPressed: () {}, child: Text("DELETE"))],
    );
  }
}
