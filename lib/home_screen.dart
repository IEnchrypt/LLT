import 'package:flutter/material.dart';
import 'package:prayertime/Payer_nav.dart';
import 'package:prayertime/events_nav.dart';
import 'package:prayertime/home_media.dart';
import 'package:prayertime/s_bar.dart';
import 'package:prayertime/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://alsunnahmcr.org/');
final Uri lurl = Uri.parse(
    'https://www.google.com/maps?ll=53.506496,-2.244598&z=17&t=m&hl=en-US&gl=US&mapclient=embed&q=13+Winterford+Rd+Cheetham+Hill+Manchester+M8+9PB+UK');
final Uri Durl = Uri.parse('https://alsunnahmcr.org/donate/');
final Uri Curl = Uri.parse('https://alsunnahmcr.org/contact-us/');

class HomeScreen extends StatefulWidget {
  final Function()? onTap;
  HomeScreen({super.key, required this.onTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  double getlength(BuildContext context) => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(246, 240, 240, 244),
        body: Stack(
          alignment: Alignment.center,
          children: [
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                  width: getBigDiameter(context) / 3.5,
                  height: getBigDiameter(context) / 3.5,
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 135, 20, 500),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 100),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: .92,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(),
                            margin: EdgeInsets.symmetric(),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                  )
                                ]),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                prayerHomeBottomBar())));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(getlength(context) / 32),
                                    child:
                                        Image.asset("assets/icons/div (4).png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(),
                            margin: EdgeInsets.symmetric(),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                  )
                                ]),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                EventsHomeBottomBar())));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(getlength(context) / 32),
                                    child:
                                        Image.asset("assets/icons/div (5).png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(),
                            margin: EdgeInsets.symmetric(),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                  )
                                ]),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: widget.onTap,
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(getlength(context) / 32),
                                    child:
                                        Image.asset("assets/icons/div (0).png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(),
                            margin: EdgeInsets.symmetric(),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                  )
                                ]),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(Durl)) {
                                      throw Exception('Could not launch $Durl');
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(getlength(context) / 32),
                                    child:
                                        Image.asset("assets/icons/div (1).png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(),
                            margin: EdgeInsets.symmetric(),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                  )
                                ]),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(Curl)) {
                                      throw Exception('Could not launch $Curl');
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(getlength(context) / 32),
                                    child:
                                        Image.asset("assets/icons/div (2).png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(),
                            margin: EdgeInsets.symmetric(),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                  )
                                ]),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(lurl)) {
                                      throw Exception('Could not launch $lurl');
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(getlength(context) / 32),
                                    child:
                                        Image.asset("assets/icons/div (3).png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
        floatingActionButton: CircleAvatar(
          radius: 25,
          backgroundColor: Color.fromARGB(255, 20, 102, 23),
          child: IconButton(
            icon: const Icon(Icons.settings, size: 25),
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: ((context) => s_bar())));
            },
          ),
        ));
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
