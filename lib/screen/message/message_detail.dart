import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:im_server_app/message_provider.dart';
import 'package:im_server_app/module/user.dart';
import 'package:provider/provider.dart';

import '../../websocket_provider.dart';
import '../../module/message_data.dart';

class MessageDetail extends StatefulWidget {
  MessageDetail(
      {Key? key,
      String? destinationId,
      Uint8List? avaterByteList,
      String? friendName})
      : destinationId = destinationId,
        friendName = friendName,
        avaterBytes = avaterByteList!,
        super(key: key);
  late String? destinationId, friendName;
  late Uint8List avaterBytes = Uint8List(100000);
  late bool messageSouceIsCurrentUser;

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  List<MessageDetailItemt> itemList = [];
  String friendName = "";

  @override
  void didChangeDependencies() {
    Provider.of<MessageState>(context).allMessagesMap.forEach((item) {
      item.forEach((key, value) {
        itemList.insert(
            0,
            MessageDetailItemt(
              avaterBytes: widget.avaterBytes,
              messageContent: value.msgContent,
              messageSouceIsCurrentUser: value.msgTo == 1,
            ));
      });
    });

    super.didChangeDependencies();
  }

  handleOnSubmit(input) {
    Provider.of<WebsocketChannelState>(context, listen: false).channel.sink.add(
        "/send_message_to_friend/" +
            input +
            "/" +
            widget.destinationId.toString() +
            "/" +
            "TEXT");
    var user = UserModel(
        id: 1, name: "test", gender: 1, password: "", avater: "avater");
    var data = MessageData(
        arriveTime: DateTime.now().toString(),
        msgFrom: "1",
        msgTo: MsgTo(userMessage: "1"),
        msgContent: input,
        msgType: 'TEXT');
    Provider.of<MessageState>(context, listen: false).addNewMessage(user, data);
    Provider.of<MessageState>(context, listen: false)
        .addAllMessageMap(user, data);
  }

  @override
  Widget build(BuildContext context) {
    print("item size" + itemList.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friendName!),
        leading: IconButton(
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_left_rounded,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: MessageState(),
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constrants) {
                return Column(children: [
                  Expanded(
                    flex: 9,
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          return itemList[index];
                        }, childCount: itemList.length))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: 150,
                        child: EditButtom(handleOnSubmit: handleOnSubmit)),
                  )
                ]);
              },
            );
          },
        ),
      ),
    );
  }
}

class MessageDetailItemt extends StatefulWidget {
  const MessageDetailItemt(
      {Key? key,
      required this.messageContent,
      required this.messageSouceIsCurrentUser,
      required this.avaterBytes})
      : super(key: key);
  final String messageContent;
  final bool messageSouceIsCurrentUser;
  final Uint8List avaterBytes;

  @override
  _MessageDetailItemtState createState() => _MessageDetailItemtState();
}

class _MessageDetailItemtState extends State<MessageDetailItemt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // color: Colors.red,
      decoration: BoxDecoration(
          color:
              widget.messageSouceIsCurrentUser ? Colors.green : Colors.white12,
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        crossAxisAlignment: widget.messageSouceIsCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundImage: MemoryImage(widget.avaterBytes),
            ),
          ),
          // Positioned(bottom: 0, child: Container(color: Colors.red,)),
          Expanded(
            flex: 8,
            child: RichText(
              text: TextSpan(
                  text: widget.messageContent,
                  style: DefaultTextStyle.of(context).style),
            ),
          )
        ],
      ),
    );
  }
}

class EditButtom extends StatelessWidget {
  const EditButtom({Key? key, required this.handleOnSubmit}) : super(key: key);
  final void Function(String) handleOnSubmit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Material(
        color: Colors.grey,
        child: Container(
          height: 100,
          child: EditableText(
            backgroundCursorColor: Colors.grey,
            focusNode: FocusNode(),
            controller: TextEditingController(),
            cursorColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            onSubmitted: handleOnSubmit,
          ),
        ),
      ),
    );
  }
}
