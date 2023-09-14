import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_chat/components/my_button.dart';
import 'package:h_chat/components/my_text_feild.dart';
import 'package:h_chat/consts/color.dart';
import 'package:h_chat/consts/text_style.dart';
import 'package:h_chat/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final cpassWordController = TextEditingController();
  void signUp() async {
    final controller = Get.put(AuthService());
    try {
      await controller.signUpWithEmailAndPassword(
          emailController.text, passWordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "HChat",
          style: ourStyle(
              size: 18.0, color: Colors.white, fWeight: FontWeight.w400),
        ),
        backgroundColor: bgDarkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SafeArea(
                child: Center(
                    child: Icon(
              Icons.message,
              size: 80,
            ))),
            const SizedBox(
              height: 45.0,
            ),
            Text(
              "Let's create an account for you!",
              style: ourStyle(size: 16.0, color: bgDarkColor),
            ),
            const SizedBox(
              height: 12.0,
            ),
            MyTextFeilds(
                myController: emailController,
                hintText: "Email",
                obscureText: false),
            const SizedBox(
              height: 12.0,
            ),
            MyTextFeilds(
                myController: passWordController,
                hintText: "Password",
                obscureText: true),
            const SizedBox(
              height: 12.0,
            ),
            MyTextFeilds(
                myController: cpassWordController,
                hintText: "Confirm Password",
                obscureText: true),
            const SizedBox(
              height: 25.0,
            ),
            MyButton(onTap: signUp, text: "Sign Up"),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a Member?"),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login Now",
                    style: ourStyle(color: bgColor, fWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
