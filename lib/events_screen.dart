import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayertime/H_B_Bar.dart';
import 'package:prayertime/home_screen.dart';

class EventScreen extends StatefulWidget {
  final Function()? onTap;
  EventScreen({super.key, required this.onTap});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  Stream? eventstream;
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  late String imgUrl;
  final storage = FirebaseStorage.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imgUrl = '';
    getimgUrl();
  }

  Future<void> getimgUrl() async {
    final ref = storage.ref().child("images/1714859616830.jpg");
    final url = await ref.getDownloadURL();
    setState(() {
      imgUrl = url;
    });
  }

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
                  width: getBigDiameter(context) / 2,
                  height: getBigDiameter(context) / 2,
                )),
            Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: getBigDiameter(context) * 1.5,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: StreamBuilder(
                          stream: events.snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot tit =
                                    snapshot.data!.docs[index];
                                return Card(
                                  elevation: 50,
                                  shadowColor: Colors.black,
                                  color: Colors.greenAccent[100],
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),

                                            child: Image.asset(
                                                'assets/3d-map-pins-gps-navigator-pin-checking-poins-3d-render-illustration 1.png'), //NetworkImage
                                          ), //CircleAvatar
                                          //CircleAvatar
                                          const SizedBox(
                                            height: 10,
                                          ), //SizedBox
                                          Text(
                                            tit['title'],
                                            style: TextStyle(
                                              fontFamily: 'Pacifico',
                                              fontSize: 30,
                                              color: Colors.green[900],
                                              fontWeight: FontWeight.w500,
                                            ), //Textstyle
                                          ), //Text
                                          const SizedBox(
                                            height: 10,
                                          ), //SizedBox
                                          Text(
                                            'Location : ${tit['location']} ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ), //Textstyle
                                          ), //Text
                                          Text(
                                            'Date & Time : ${tit['time']}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                            ), //Textstyle
                                          ), //Text
                                          const SizedBox(
                                            height: 10,
                                          ), //SizedBox
                                        ],
                                      ), //Column
                                    ), //Padding
                                  ), //SizedBox
                                );
                              },
                            );
                          }))),
            )
          ],
        ),
        floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Color.fromARGB(255, 20, 102, 23),
          child: IconButton(
            icon: const Icon(Icons.screen_share, size: 40),
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: widget.onTap,
          ),
        ));
  }
}
