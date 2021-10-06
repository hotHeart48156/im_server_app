import 'package:flutter/material.dart';
import 'package:im_server_app/screen/register/register_background.dart';
import 'package:im_server_app/screen/register/register_form.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
  final formKey = GlobalKey<FormState>();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterBody(),
    );
  }
}

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: RegisterBackground(
          child: RegisterForm(
            formkey: GlobalKey(),
          ),
        ),
      ),
    );
  }
}
