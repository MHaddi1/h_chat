import 'package:flutter/material.dart';
import 'package:h_chat/consts/color.dart';
import 'package:h_chat/consts/text_style.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(
                12.0,
              ),
              topRight: Radius.circular(12.0))),
      child: Text(
        message,
        style: ourStyle(color: whiteColor),
      ),
    );
  }
}
