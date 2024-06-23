import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signupScreen extends StatelessWidget {
  final Function()? onTap;
  signupScreen({super.key, required this.onTap});
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final Name_controller = TextEditingController();
  final password_config_controller = TextEditingController();
  final Number_controller = TextEditingController();

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  void signupuser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_controller.text, password: password_controller.text);
  }

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
                  margin: EdgeInsets.fromLTRB(20, 230, 20, 1),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: Number_controller,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 20, 178, 110),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Full Name",
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
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 1),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: password_config_controller,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Color.fromARGB(255, 20, 178, 110),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                        labelText: "Confirm Password",
                        enabledBorder: InputBorder.none,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
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
                        signupuser();
                      },
                      borderRadius: BorderRadius.circular(20),
                      splashColor: const Color.fromARGB(255, 76, 210, 80),
                      child: Center(
                        child: Text(
                          "Create Account",
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
                      "Already Have Account ?",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "sign in ",
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
