import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_server_app/constant.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final screen_width = ScreenWidth(context);
    return Container(
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
                right: 0,
                child: Image.asset(
                  "assert/images/login_bottom.png",
                  width: screen_width * 0.2,
                )),
            Center(child: child)
          ],
        ));
  }
}
