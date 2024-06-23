import 'package:flutter/material.dart';
import 'package:prayertime/events_rec.dart';
import 'package:prayertime/events_screen.dart';
import 'package:prayertime/prayer_screen.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://alsunnahmcr.org/');

class ItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: .91,
      children: [
        Container(
          padding: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(),
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
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
                          builder: ((context) => PrayerScreen())));
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Image.asset("assets/icons/div (4).png"),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(),
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => event_rec())));
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Image.asset("assets/icons/div (5).png"),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(),
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
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
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Image.asset("assets/icons/div (0).png"),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(),
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
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
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Image.asset("assets/icons/div (1).png"),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(),
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
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
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Image.asset("assets/icons/div (2).png"),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(),
          margin: EdgeInsets.symmetric(),
          decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
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
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  child: Image.asset("assets/icons/div (3).png"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
