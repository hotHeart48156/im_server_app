import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_server_app/color.dart';
import 'package:im_server_app/component/round_buttom.dart';
import 'package:im_server_app/screen/login/login_page.dart';
import 'package:im_server_app/service/user.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required GlobalKey<FormState> formkey,
  })  : _formkey = formkey,
        super(key: key);

  final GlobalKey<FormState> _formkey;

  @override
  Widget build(BuildContext context) {
    String username = "", password = "";
    return Form(
        key: _formkey,
        // autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assert/icons/login.svg"),
            TextFieldContainer(
                child: InputField(
              hintText: "Username",
              onChange: (value) {},
              icon: Icon(
                Icons.person,
                color: PrimaryColor,
              ),
              validator: (value) {
                username = value!;
              },
            )),
            TextFieldContainer(
                child: PasswordField(
              hintText: "Password",
              onChange: (value) {
                // password = value;
              },
              icon: Icon(
                Icons.lock,
                color: PrimaryColor,
              ),
              validator: (value) {
                print("password  " + value!);
                password = value;
              },
            )),
            RoundButtom(
                text: Text(
                  "Submit",
                  style: TextStyle(fontSize: 24),
                ),
                color: PrimaryColor,
                press: () {
                  if (_formkey.currentState!.validate() &&
                      username != "" &&
                      password != "") {
                    Register.register(username, password).then((value) =>
                        {Navigator.pushNamed(context, "/login"), print(value)});
                  } else {
                    print(username + "--" + password);
                  }
                })
          ],
        ));
  }
}
