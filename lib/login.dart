import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email_controller = TextEditingController();

  final password_controller = TextEditingController();
  void signuserin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_controller.text, password: password_controller.text);
  }

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 240, 240, 244),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: -getSmallDiameter(context) / 2.8,
              child: Image.asset(
                "assets/image.png",
                width: getBigDiameter(context) * 1.15,
                height: getBigDiameter(context),
              )),
          Positioned(
              top: -getSmallDiameter(context) / 30 + 50,
              child: Image.asset(
                "assets/New-Logo-A-Sunnah-Mosque-01 1.png",
                alignment: Alignment.center,
                width: getBigDiameter(context) / 2,
                height: getBigDiameter(context) / 2,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 300, 20, 1),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: email_controller,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 20, 178, 110),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Email",
                        enabledBorder: InputBorder.none,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 1),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: password_controller,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color.fromARGB(255, 20, 178, 110),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Password",
                        enabledBorder: InputBorder.none,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Password ?",
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ))),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(227, 65, 205, 86),
                          Color.fromARGB(44, 73, 3, 3)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        signuserin();
                      },
                      borderRadius: BorderRadius.circular(20),
                      splashColor: const Color.fromARGB(255, 76, 210, 80),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have Account ?",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "sign up ",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
