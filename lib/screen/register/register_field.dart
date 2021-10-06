import 'package:flutter/material.dart';
import 'package:im_server_app/color.dart';
import 'package:im_server_app/constant.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var screen_width = ScreenWidth(context);
    return Container(
      width: screen_width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 4),
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
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(fontSize: 24, color: Colors.grey),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please input password";
        } else {
          // password = value;
        }
      },
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
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 24,
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
