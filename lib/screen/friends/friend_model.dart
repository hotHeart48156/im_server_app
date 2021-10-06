/// id : 1
/// user_id : 1
/// friend_id : 2

class Friend_model {
  Friend_model({
    required int id,
    required int userId,
    required int friendId,
  }) {
    _id = id;
    _userId = userId;
    _friendId = friendId;
  }

  Friend_model.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _friendId = json['friend_id'];
  }
  int _id = 0;
  int _userId = 0;
  int _friendId = 0;

  int get id => _id;
  int get userId => _userId;
  int get friendId => _friendId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['friend_id'] = _friendId;
    return map;
  }
}
