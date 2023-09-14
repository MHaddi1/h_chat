import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:h_chat/services/auth/login_or_register.dart';
import 'package:h_chat/views/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is Logined in
            if (snapshot.hasData) {
              return const HomePage();
            } //user is Not Logined in
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
