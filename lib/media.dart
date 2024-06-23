import 'package:flutter/material.dart';
import 'package:prayertime/Payer_nav.dart';
import 'package:prayertime/events_nav.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri facebook =
    Uri.parse('https://www.facebook.com/alsunnahmosque/?locale=en_GB');
final Uri _x = Uri.parse('https://twitter.com/AlsunnahMCR');
final Uri yt =
    Uri.parse('https://www.youtube.com/channel/UCAZl3Zp1XcvRNspqfQUjBgg');
final Uri wts = Uri.parse('https://chat.whatsapp.com/C6ZjYsfIzObHoBQzU6pAmE');

class media extends StatefulWidget {
  final Function()? onTap;
  media({super.key, required this.onTap});

  @override
  State<media> createState() => _mediaState();
}

class _mediaState extends State<media> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  double getlength(BuildContext context) =>
      MediaQuery.of(context).size.height;

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
                      margin: EdgeInsets.fromLTRB(20, 200, 20, 1),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: .91,
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
                                  onTap: () async {
                                    if (!await launchUrl(facebook)) {
                                      throw Exception(
                                          'Could not launch $facebook');
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(getlength(context)/32),
                                    child: Image.asset("assets/facebook.png"),
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
                                    if (!await launchUrl(_x)) {
                                      throw Exception('Could not launch $_x');
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(getlength(context)/32),
                                    child: Image.asset("assets/x.png"),
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
                                    if (!await launchUrl(wts)) {
                                      throw Exception('Could not launch $wts');
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(getlength(context)/32),
                                    child: Image.asset("assets/wts.png"),
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
                                    if (!await launchUrl(yt)) {
                                      throw Exception('Could not launch $yt');
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(getlength(context)/32),
                                    child: Image.asset("assets/youtube.png"),
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
          radius: 30,
          backgroundColor: Color.fromARGB(255, 20, 102, 23),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, size: 40),
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: widget.onTap,
          ),
        ));
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(facebook)) {
    throw Exception('Could not launch $facebook');
  }
}
