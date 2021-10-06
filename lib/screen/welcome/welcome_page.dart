import 'package:flutter/material.dart';
import 'package:im_server_app/screen/welcome/welcome_body.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: WelcomeBody(),
      ),
    );
  }
}
