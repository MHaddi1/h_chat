import 'package:flutter/material.dart';
import 'package:h_chat/consts/color.dart';
import 'package:h_chat/consts/text_style.dart';

class MyTextFeilds extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final bool obscureText;
  const MyTextFeilds(
      {super.key,
      required this.myController,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: myController,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: whiteColor),
          ),
          fillColor: Colors.grey[100],
          filled: true,
          hintStyle: ourStyle(color: bgDarkColor)
        ));
  }
}
