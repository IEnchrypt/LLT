import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:prayertime/H_B_Bar.dart';
import 'package:prayertime/Payer_nav.dart';
import 'package:prayertime/back_h.dart';
import 'package:prayertime/events_nav.dart';
import 'package:prayertime/home_media.dart';
import 'package:prayertime/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri facebook =
    Uri.parse('https://www.facebook.com/alsunnahmosque/?locale=en_GB');
final Uri _x = Uri.parse('https://twitter.com/AlsunnahMCR');
final Uri yt =
    Uri.parse('https://www.youtube.com/channel/UCAZl3Zp1XcvRNspqfQUjBgg');
final Uri wts = Uri.parse('https://chat.whatsapp.com/C6ZjYsfIzObHoBQzU6pAmE');

class settings extends StatefulWidget {
  settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
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
            Container(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Select Default Notification sound'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('       Full Adhan      '),
                      onPressed: () {
                        FlutterRingtonePlayer()
                            .play(fromAsset: "audio/adhan_sst.mp3");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('Takbir From adhan'),
                      onPressed: () {
                        FlutterRingtonePlayer()
                            .play(fromAsset: "audio/mohamed_bashier_azan.mp3");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('    Fajr Reminder     '),
                      onPressed: () {
                        FlutterRingtonePlayer().play(

                            ///android: AndroidSounds.notification,
                            ///ios: const IosSound(1023),
                            fromAsset: "audio/Islamic_Alarm_Tone.mp3");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('       playRingtone    '),
                      onPressed: () {
                        FlutterRingtonePlayer().playNotification();

                        // ignore: unused_label
                      },
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
        floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Color.fromARGB(255, 20, 102, 23),
          child: IconButton(
              icon: const Icon(Icons.arrow_back_sharp, size: 40),
              color: Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => HomeBottomBarback())));
              }),
        ));
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(facebook)) {
    throw Exception('Could not launch $facebook');
  }
}
