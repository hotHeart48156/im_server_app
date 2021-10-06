import 'package:flutter/cupertino.dart';
import 'package:im_server_app/service/basic.dart';
import 'package:im_server_app/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Websocket {
  static WebSocketChannel websocketConnect(BuildContext context) {
    UserState tk = Provider.of<UserState>(context);
    var channel = IOWebSocketChannel.connect(wsUrl,
        headers: {"token": tk.getToken().token});

    return channel;
  }
}
