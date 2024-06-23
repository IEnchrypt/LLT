import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:prayertime/events_rec.dart';
import 'package:prayertime/events_screen.dart';
import 'package:prayertime/home_media.dart';
import 'package:prayertime/home_screen.dart';
import 'package:prayertime/media.dart';
import 'package:prayertime/prayer_screen.dart';
import 'package:prayertime/recorded_lectures.dart';

class EventsHomeBottomBar extends StatefulWidget {
  @override
  State<EventsHomeBottomBar> createState() => _EventsHomeBottomBarState();
}

class _EventsHomeBottomBarState extends State<EventsHomeBottomBar> {
  List Screens = [
    home_media(),
    PrayerScreen(),
    event_rec(),
  ];
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Color.fromARGB(255, 135, 189, 137),
        color: Color.fromARGB(255, 31, 113, 34),
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.event,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Screens[_selectedIndex],
    );
  }
}
