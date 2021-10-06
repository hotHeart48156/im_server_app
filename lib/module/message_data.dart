import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part './mm.g.dart';

@JsonSerializable()
class MessageData {
  @JsonKey(name: 'msg_content')
  String msgContent;
  @JsonKey(name: 'msg_from')
  String msgFrom;
  @JsonKey(name: 'msg_type')
  String msgType;
  @JsonKey(name: 'msg_to')
  MsgTo msgTo;
  @JsonKey(name: 'arrive_time')
  String arriveTime;

  MessageData({
    required this.msgContent,
    required this.msgFrom,
    required this.msgType,
    required this.msgTo,
    required this.arriveTime,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDataToJson(this);

  Map<String, dynamic> toMap() {
    return {
      "msg_content": msgContent,
      "msg_from": msgFrom,
      "msg_to": msgTo.userMessage,
      "arrive_time": arriveTime
    };
  }

  // MessageData.fromJson(Map<String, dynamic> json)
  //     : msgContent = json['msg_content'],
  //       msgFrom = json['msg_from'],
  //       msgType = json['msg_type'],
  //       msgTo   = json['msg_to'],
  //       arriveTime = json['arrive_time'];
  //
  //
  // Map<String, dynamic> toJson() => {
  //   'name': msgContent,
  //   'email': msgFrom,
  // };
}

@JsonSerializable()
class MsgTo {
  @JsonKey(name: 'UserMessage')
  String userMessage;
  factory MsgTo.fromJson(Map<String, dynamic> json) => _$MsgToFromJson(json);
  Map<String, dynamic> toJson() => _$MsgToToJson(this);
  MsgTo({
    required this.userMessage,
  });
}
