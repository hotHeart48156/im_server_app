import 'package:flutter/material.dart';

class NoLogin extends StatelessWidget {
  const NoLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "NOT LOGIN",
          style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
