import 'package:flutter/material.dart';
import 'package:h_chat/consts/color.dart';
import 'package:h_chat/consts/text_style.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
            color: bgDarkColor, borderRadius: BorderRadius.circular(12.0)),
        child: Center(
            child: Text(
          text,
          style: ourStyle(color: whiteColor),
        )),
      ),
    );
  }
}
