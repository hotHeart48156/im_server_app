import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketChannelState with ChangeNotifier {
  late WebSocketChannel channel;

  void setChannel(WebSocketChannel channel) {
    this.channel = channel;
  }
}
