import 'package:flutter/material.dart';
import 'package:prayertime/events_screen.dart';
import 'package:prayertime/recorded_lectures.dart';
import 'package:prayertime/videolist.dart';

class event_rec extends StatefulWidget {
  const event_rec({super.key});

  @override
  State<event_rec> createState() => _event_recState();
}

class _event_recState extends State<event_rec> {
  bool showlogin = true;
  void togglepages() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return EventScreen(
        onTap: togglepages,
      );
    } else {
      return VideoList(
        onTap: togglepages,
      );
    }
  }
}
