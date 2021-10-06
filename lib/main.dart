import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_server_app/color.dart';
import 'package:im_server_app/provider_setup.dart';
import 'package:im_server_app/screen/NoLogin.dart';
import 'package:im_server_app/screen/friends/friends_page.dart';
import 'package:im_server_app/screen/login/login_page.dart';
import 'package:im_server_app/screen/main/main_page.dart';
import 'package:im_server_app/screen/message/message_detail.dart';
import 'package:im_server_app/screen/message/message_page.dart';
import 'package:im_server_app/screen/my/my_page.dart';
import 'package:im_server_app/screen/register/register_page.dart';
import 'package:im_server_app/screen/welcome/welcome_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: providers, child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chat_app',
      theme: AppTheme(),
      // home: LoginPage(
      //   key: Key("login"),
      // ),
      initialRoute: '/',

      routes: {
        '/': (context) => Welcome(),
        '/login': (context) => const LoginPage(),
        "/register": (context) => RegisterPage(),
        "/message": (context) => MessagePage(),
        "/message_detail": (context) => MessageDetail(),
        "/friends": (context) => FriendsPage(),
        "/my": (context) => MyPage(),
        "/main": (context) => MainPage(),
        "/not_login": (context) => NoLogin()
      },
      onGenerateRoute: (event) {},
    );
  }

  ThemeData AppTheme() {
    return ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(),
        backgroundColor: Colors.white70,
        primaryColor: PrimaryColor,
        primaryColorLight: PrimaryLightColor,
        scaffoldBackgroundColor: Colors.white,
        // fontFamily: GoogleFonts,
        appBarTheme: AppBarTheme(color: Colors.white));
  }
}
