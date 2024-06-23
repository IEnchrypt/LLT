import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:prayertime/H_B_Bar.dart';
import 'package:prayertime/events_screen.dart';
import 'package:prayertime/home_screen.dart';
import 'package:prayertime/media.dart';
import 'package:prayertime/prayer_screen.dart';
import 'package:prayertime/recorded_lectures.dart';

class home_media extends StatefulWidget {
  @override
  State<home_media> createState() => _home_mediaState();
}

class _home_mediaState extends State<home_media> {
  bool showlogin = true;
  void togglepages() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return HomeScreen(
        onTap: togglepages,
      );
    } else {
      return media(
        onTap: togglepages,
      );
    }
  }
}
