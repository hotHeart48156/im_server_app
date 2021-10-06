// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../module/message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      msgContent: json['msg_content'] as String,
      msgFrom: json['msg_from'] as String,
      msgType: json['msg_type'] as String,
      msgTo: MsgTo.fromJson(json['msg_to'] as Map<String, dynamic>),
      arriveTime: json['arrive_time'] as String,
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'msg_content': instance.msgContent,
      'msg_from': instance.msgFrom,
      'msg_type': instance.msgType,
      'msg_to': instance.msgTo,
      'arrive_time': instance.arriveTime,
    };

MsgTo _$MsgToFromJson(Map<String, dynamic> json) => MsgTo(
      userMessage: json['UserMessage'] as String,
    );

Map<String, dynamic> _$MsgToToJson(MsgTo instance) => <String, dynamic>{
      'UserMessage': instance.userMessage,
    };
