import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_server_app/color.dart';
import 'package:im_server_app/component/round_buttom.dart';
import 'package:im_server_app/constant.dart';
import 'package:im_server_app/screen/login/login_background.dart';
import 'package:im_server_app/service/user.dart';
import 'package:web_socket_channel/src/channel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: LoginBody()),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginBackground(
        child: LoginForm(
          formkey: GlobalKey(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer(),
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
                  print("change");
                },
                icon: Icon(
                  Icons.lock,
                  color: PrimaryColor,
                ),
                validator: (value) {
                  print("validate");
                  password = value!;
                },
              )),

              RoundButtom(
                  text: Text(
                    "Submit",
                    style: TextStyle(fontSize: 24),
                  ),
                  color: PrimaryColor,
                  press: () {
                    if (_formkey.currentState!.validate()) {
                      WebSocketChannel channel;
                      Login.login(username, password, context).then((value) => {
                            if (value == false)
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK')),
                                      ],
                                      title: Text("error login"),
                                      content: SingleChildScrollView(
                                        child: Text("ERROR LOGIN"),
                                      ),
                                    );
                                  },
                                )
                              }
                            else
                              {Navigator.pushNamed(context, "/main")}
                          });
                    }

                    // t.onError((error, stackTrace) => null);
                  })
            ],
          ),
        ));
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var screen_width = ScreenWidth(context);
    return Container(
      width: screen_width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: child,
      decoration: BoxDecoration(
          color: PrimaryLightColor, borderRadius: BorderRadius.circular(29)),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.onChange,
      required this.validator})
      : super(key: key);
  final String hintText;
  final Icon icon;
  final ValueChanged<String> onChange;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      focusNode: FocusNode(),
      onSaved: (password) {
        password = password;
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
        border: InputBorder.none,
        icon: Icon(
          Icons.lock,
          color: PrimaryColor,
        ),
        suffixIcon: Icon(
          Icons.visibility_off,
          color: PrimaryColor,
        ),
      ),
      onFieldSubmitted: (username) {},
      validator: validator,
      onChanged: onChange,
    );
  }
}

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.onChange,
      required this.validator})
      : super(key: key);
  final String hintText;
  final Icon icon;
  final ValueChanged<String> onChange;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      strutStyle: StrutStyle(),
      onSaved: (username) {
        username = username;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.visibility,
            color: PrimaryColor,
          ),
          icon: icon),

      // onFieldSubmitted: (username) {
      //   username = username;
      // },
      validator: validator,
      onChanged: onChange,
    );
  }
}
