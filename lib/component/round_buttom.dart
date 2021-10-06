import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_server_app/constant.dart';

class RoundButtom extends StatelessWidget {
  const RoundButtom(
      {Key? key, required this.text, required this.color, required this.press})
      : super(key: key);
  final Text text;
  final Color color;
  final Function press;
  @override
  Widget build(BuildContext context) {
    final screen_width = ScreenWidth(context);
    final screen_height = ScreenHeight(context);

    return Container(
      width: screen_width * 0.9,
      height: screen_height * 0.08,
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          onPressed: () => {press()},
          child: text,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => color)),
        ),
      ),
    );
  }
}
