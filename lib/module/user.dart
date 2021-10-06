/// id : 2
/// name : "test1"
/// gender : 0
/// password : "test"
/// avater : "4373d88774c103882f82706cb99a76d32.webp"

class UserModel {
  UserModel({
    required int id,
    required String name,
    required int gender,
    required String password,
    required String avater,
  }) {
    _id = id;
    _name = name;
    _gender = gender;
    _password = password;
    _avater = avater;
  }

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _gender = json['gender'];
    _password = json['password'];
    _avater = json['avater'];
  }
  int _id = 0;
  String _name = "";
  int _gender = 0;
  String _password = "";
  String _avater = "";

  int get id => _id;
  String get name => _name;
  int get gender => _gender;
  String get password => _password;
  String get avater => _avater;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['gender'] = _gender;
    map['password'] = _password;
    map['avater'] = _avater;
    return map;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['user_id'] = _id;
    map['name'] = _name;
    map['gender'] = _gender;
    map['avater'] = _avater;
    return map;
  }
}
