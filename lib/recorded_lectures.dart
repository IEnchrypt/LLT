import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayertime/H_B_Bar.dart';
import 'package:prayertime/home_screen.dart';
import 'package:prayertime/service/files.dart';
import 'package:prayertime/service/firebase_file.dart';
import 'package:prayertime/service/image_page.dart';

class recorded_lectures_screen extends StatefulWidget {
  final Function()? onTap;
  recorded_lectures_screen({super.key, required this.onTap});

  @override
  State<recorded_lectures_screen> createState() =>
      _recorded_lectures_screenState();
}

class _recorded_lectures_screenState extends State<recorded_lectures_screen> {
  CollectionReference events = FirebaseFirestore.instance.collection('events');
  Stream? eventstream;
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  late Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('videos/');
  }

  late String imgUrl;
  final storage = FirebaseStorage.instance;

  Future<void> getimgUrl() async {
    final ref = storage.ref().child("images/1714859616830.jpg");
    final url = await ref.getDownloadURL();
    setState(() {
      imgUrl = url;
    });
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Color.fromARGB(255, 20, 122, 66),
          ),
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Color.fromARGB(255, 18, 103, 42),
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Lectures',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recorded lectures'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(files.length),
                      const SizedBox(height: 40),
                      Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];

                            return buildFile(context, file);
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
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
