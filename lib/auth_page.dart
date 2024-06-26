import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayertime/H_B_Bar.dart';
import 'package:prayertime/home_screen.dart';
import 'package:prayertime/login_or_register.dart';

class auth_page extends StatelessWidget {
  const auth_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeBottomBar();
          } else {
            return loginorregister();
          }
        },
      ),
    );
  }
}
