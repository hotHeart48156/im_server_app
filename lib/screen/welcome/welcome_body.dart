import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_server_app/color.dart';
import 'package:im_server_app/component/round_buttom.dart';
import 'package:im_server_app/constant.dart';
import 'package:im_server_app/screen/welcome/welcome_background.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WelcomeBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WELCOME TO CHAT",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SvgPicture.asset("assert/icons/chat.svg"),
          RoundButtom(
            text: Text("Login"),
            color: PrimaryColor,
            press: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
          RoundButtom(
            text: Text("Register"),
            color: PrimaryLightColor,
            press: () {
              Navigator.pushNamed(context, "/register");
            },
          )
        ],
      ),
    );
  }
}
