/// msg_content : "hello"
/// msg_from : "2"
/// msg_type : "Text"
/// msg_to : {"UserMessage":"2"}
/// arrive_time : "2021-09-28 11:15:29"

class Message {
  Message({
    required String msgContent,
    required String msgFrom,
    required String msgType,
    required Msg_to msgTo,
    required String arriveTime,
  }) {
    _msgContent = msgContent;
    _msgFrom = msgFrom;
    _msgType = msgType;
    _msgTo = msgTo;
    _arriveTime = arriveTime;
  }

  Message.fromJson(dynamic json) {
    _msgContent = json['msg_content'];
    _msgFrom = json['msg_from'];
    _msgType = json['msg_type'];
    _msgTo = (json['msg_to'] != null ? Msg_to.fromJson(json['msgTo']) : null)!;
    _arriveTime = json['arrive_time'];
  }

  Map<String, dynamic> toMap() {
    return {
      "msg_content": _msgContent,
      "msg_from": _msgFrom,
      "msg_to": _msgTo.userMessage,
      "arrive_time": _arriveTime
    };
  }

  String _msgContent = "";
  String _msgFrom = "";
  String _msgType = "";
  Msg_to _msgTo = Msg_to(userMessage: "");
  String _arriveTime = "";

  String get msgContent => _msgContent;

  String get msgFrom => _msgFrom;

  String get msgType => _msgType;

  Msg_to get msgTo => _msgTo;

  String get arriveTime => _arriveTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg_content'] = _msgContent;
    map['msg_from'] = _msgFrom;
    map['msg_type'] = _msgType;
    if (_msgTo != null) {
      map['msg_to'] = _msgTo.toJson();
    }
    map['arrive_time'] = _arriveTime;
    return map;
  }
}

/// UserMessage : "2"

class Msg_to {
  Msg_to({
    required String userMessage,
  }) {
    _userMessage = userMessage;
  }

  Msg_to.fromJson(dynamic json) {
    _userMessage = json['UserMessage'];
  }

  String _userMessage = "";

  String get userMessage => _userMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserMessage'] = _userMessage;
    return map;
  }
}
