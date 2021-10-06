import 'package:flutter/material.dart';
import 'package:im_server_app/constant.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screen_height = ScreenHeight(context);
    final screen_width = ScreenWidth(context);

    return Container(
      height: screen_height,
      width: screen_width,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assert/images/main_top.png",
                width: screen_width * 0.3,
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assert/images/main_bottom.png",
                width: screen_width * 0.2,
              )),
          Center(child: child)
        ],
      ),
    );
  }
}
