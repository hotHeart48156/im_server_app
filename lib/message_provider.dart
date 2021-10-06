import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:im_server_app/module/message_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'module/user.dart';

class MessageState extends ChangeNotifier {
  late List<Map<UserModel, MessageData>> allMessagesMap = [];
  late List<Map<UserModel, MessageData>> newMessageList = [];

  void addNewMessage(UserModel user, MessageData data) {
    // newMessageList.forEach((element) async  {
    //   log("yes");
    //   element.forEach((key, value) {
    //     if(key.id==user.id){
    //       newMessageList.remove(element);
    //     }
    //     print("insear new message inner");
    //     newMessageList.insert(0, {user:data});
    //   });
    // });
    print("add new message" + newMessageList.length.toString());
    if (newMessageList.length == 0) {
      newMessageList.insert(0, {user: data});
    }
    Map<UserModel, MessageData> element;

    for (element in newMessageList) {
      print("yes");
      element.forEach((key, value) {
        if (key.id == user.id) {
          print("delete same");
          newMessageList.remove(element);
        }
        print("insear new message inner");
        newMessageList.insert(0, {user: data});
      });
    }
    notifyListeners();
  }

  void addAllMessageMap(UserModel user, MessageData data) {
    allMessagesMap.insert(0, {user: data});
    print("add all message" + allMessagesMap.length.toString());
    notifyListeners();
  }

  List<Map<UserModel, MessageData>> getUserMessagesById(String id) {
    List<Map<UserModel, MessageData>> list = [];
    this.allMessagesMap.forEach((element) {
      element.forEach((key, value) {
        print(value.msgFrom == id);
        print(value.msgFrom + id);

        if (value.msgFrom == id) {
          list.add(element);
        }
      });
    });
    return list;
  }

  void saveAllMessageToSql() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = join(await getDatabasesPath(), 'test1.db');
    var db = openDatabase(path, version: 3, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE Messages(
          id INTEGER PRIMARY KEY
          ,user_id varchar(20)
          ,name varchar(20)
          ,gender varchar(20)
          ,avater varchar(20)
          ,msg_content varchar(20)
          ,msg_from varchar(20)
          ,msg_to varchar(20)
          ,arrive_time varchar(20)
      )
      ''');
      await db.execute('''
          CREATE TABLE NewMessages(
          id INTEGER PRIMARY KEY
          ,user_id varchar(20)
          ,name varchar(20)
          ,gender varchar(20)
          ,avater varchar(20)
          ,msg_content varchar(20)
          ,msg_from varchar(20)
          ,msg_to varchar(20)
          ,arrive_time varchar(20)
          )
          ''');
      // return;
    }, onOpen: (db) async {
      // allMessagesMap.forEach((element) async {
      //   element.forEach((key, value) {
      //     Map<String, dynamic> v = key.toMap();
      //     value.
      //     print("message provider keys  " + v.keys.toString());
      //     print("message provider values  " + v.values.toString());
      //     db.insert("Messages", v);
      //     // db.execute('''
      //     // drop database chat_app.db
      //     // ''');
      //   });
      allMessagesMap.forEach((element) {
        element.forEach((key, value) {
          var v = key.toMap();
          v.addAll(value.toMap());
          db.insert("Messages", v);
        });
      });

      newMessageList.forEach((element) {
        element.forEach((key, value) {
          var v = key.toMap();
          v.addAll(value.toMap());
          db.insert("NewMessages", v);
          var result = db.query("NewMessages",
              columns: ["user_id"], where: 'user_id=?', whereArgs: [key.id]);
          result.then((value) => value.forEach((element) {
                element.forEach((key, value) {
                  if (value == v["user_id"]) {
                    db.update("NewMessages", v,
                        where: "user_id=?", whereArgs: v["user_id"]);
                  } else {
                    db.insert("NewMessages", v);
                  }
                });
              }));
        });
      });

      // return;
    });
  }
}

void saveNewMessageToSql() async {
  final path = join(await getDatabasesPath(), 'test.db');
  openDatabase(path, version: 3, onCreate: (db, version) async {
    await db.execute('''
          CREATE TABLE NewMessages(
          id INTEGER PRIMARY KEY
          ,user_id varchar(20)
          ,name varchar(20)
          ,gender varchar(20)
          ,avater varchar(20)
          ,msg_content varchar(20)
          ,msg_from varchar(20)
          ,msg_to varchar(20)
          ,arrive_time varchar(20)
          )
          ''');
    // return;
  }, onOpen: (db) async {
    print("save new messgaes");
  });
}
