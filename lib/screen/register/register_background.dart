import 'package:flutter/material.dart';
import 'package:im_server_app/constant.dart';

class RegisterBackground extends StatelessWidget {
  const RegisterBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenHeight(context);
    final screenWidght = ScreenWidth(context);
    return Container(
      height: screenHeight,
      width: screenWidght,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assert/images/signup_top.png",
                width: screenWidght * 0.3,
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assert/images/login_bottom.png",
                width: screenWidght * 0.3,
              )),
          Center(
            child: child,
          )
        ],
      ),
    );
  }
}
