import 'package:flutter/widgets.dart';

class Token {
  String token;
  Token(this.token);
  @override
  String toString() {
    return "token:" + token;
  }

  static Token defaultValue() {
    return Token("");
  }
}

class UserState extends ChangeNotifier {
  var token = Token.defaultValue();

  void updateToken(Token tk) {
    this.token = tk;
    notifyListeners();
  }

  Token getToken() {
    return token;
  }
}
