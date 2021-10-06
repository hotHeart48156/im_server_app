import 'package:im_server_app/message_provider.dart';
import 'package:im_server_app/user_provider.dart';
import 'package:im_server_app/websocket_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildStatelessWidget> providers = [
  ChangeNotifierProvider<UserState>(create: (_) => UserState()),
  ChangeNotifierProvider<MessageState>(create: (_) => MessageState()),
  ChangeNotifierProvider<WebsocketChannelState>(
      create: (_) => WebsocketChannelState())
];
