import 'package:flutter/material.dart';
import 'package:prayertime/login.dart';
import 'package:prayertime/sign_up.dart';

class loginorregister extends StatefulWidget {
  const loginorregister({super.key});

  @override
  State<loginorregister> createState() => _loginorregisterState();
}

class _loginorregisterState extends State<loginorregister> {
  bool showlogin = true;
  void togglepages() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return LoginScreen(
        onTap: togglepages,
      );
    } else {
      return signupScreen(
        onTap: togglepages,
      );
    }
  }
}
