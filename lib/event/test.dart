import 'package:im_server_app/event/actor.dart';
import 'package:im_server_app/event/hander.dart';

class Login {
  String username = "", password = "";
  Login(String username, String password) {
    this.username = username;
    this.password = password;
  }
}

class Register {
  String username = "", password = "";
  Login(String username, String password) {
    this.username = username;
    this.password = password;
  }
}

class Test implements Actor, Handler<Login> {
  @override
  Actor start() {
    // TODO: implement start
    return this;
  }

  @override
  Result handle(Login msg) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class Exec {
  Test test = Test();
  void ff() {}
}
