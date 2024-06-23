import 'dart:math';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:prayertime/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prayertime/service/delta_T_manager.dart';

import 'package:prayertime/service/firebase_API.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

@override
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await firebaseMSG().initNotification();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  DateTime date = (DateTime.now());
  Coordinates coordinates =
      Coordinates(53.506516477842055, -2.2445736729918266);
  CalculationParameters params = CalculationMethod.UmmAlQura();
  params.madhab = Madhab.Shafi;
  final PT = PrayerTimes(coordinates, date, params, precision: true);
  AwesomeNotifications().initialize('resource://drawable/launcher_icon', [
    NotificationChannel(
      channelKey: "channelKey",
      channelName: "adan_channel",
      channelDescription: "channelDescription",
      channelShowBadge: true,
      enableLights: true,
      enableVibration: true,
      importance: NotificationImportance.Max,
      playSound: true,
      soundSource:
          "resource://raw/res_mysound", //will be rectified later (connected to the slected sound from user , or getting default sys.notif.sound)
    )
  ]);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      AwesomeNotifications().createNotification(
          schedule: NotificationCalendar(
            preciseAlarm: true,
            allowWhileIdle: true,
            repeats: true,
            hour: 16,
            minute: 50,
            second: 0,
          ),
          content: NotificationContent(
              showWhen: false,
              wakeUpScreen: true,
              displayOnBackground: true,
              displayOnForeground: true,
              category: NotificationCategory.Reminder,
              id: Random().nextInt(99999),
              channelKey: 'adan_channel',
              title: PT.currentPrayer(date: DateTime.now()).toString(),
              body: 'Salah time',
              actionType: ActionType.KeepOnTop));
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth_page(),
    );
  }
}
