import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jhijri/jHijri.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:prayertime/main.dart';

class pt_screen_v2 extends StatefulWidget {
  const pt_screen_v2({super.key});

  @override
  State<pt_screen_v2> createState() => _testState();
}

class _testState extends State<pt_screen_v2> {
  late PrayerTimes prayerTimes;
  late DateTime date;
  late Coordinates coordinates;
  late CalculationParameters params;
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _currentAdress = '';
  CollectionReference events =
      FirebaseFirestore.instance.collection('prayers-time');
  Stream? eventstream;

  @override
  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  List<List<dynamic>> _data = [];
  @override
  void _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/FullYearTiming-2.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    setState(() {
      _data = listData;
    });
  }

  @override
  void initState() {
    DateTime date = (DateTime.now());
    Coordinates coordinates =
        Coordinates(53.506516477842055, -2.2445736729918266);
    CalculationParameters params = CalculationMethod.UmmAlQura();
    params.madhab = Madhab.Shafi;
    prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    triggernotif();

    ///Noti.showBigTextNotification(title: "New message title",body: "Your long body",fln: flutterLocalNotificationsPlugin);
    _loadCSV();
    super.initState();
  }

  triggernotif() {
    DateTime date = (DateTime.now());
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 12,
            channelKey: 'channelKey',
            title: 'Prayers',
            body: 'Current Prayer ${prayerTimes.currentPrayer(date: date)} ' +
                'Next Prayer ${prayerTimes.nextPrayer()}',
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture: 'resource://drawable/launcher_icon'));
  }

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  double getlat(BuildContext context) => MediaQuery.of(context).size.height;

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
                width: getBigDiameter(context) / 4,
                height: getBigDiameter(context) / 4,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(2, 110, 10, 1),
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: getlat(context) / 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "${DateTime.now().hour}:${minutes()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getlat(context) / 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: getlat(context) / 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        getDateg(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getlat(context) / 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: getlat(context) / 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        getDate(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: getlat(context) / 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 1),
                    width: MediaQuery.of(context).size.width,
                    height: getlat(context) / 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 185, 213, 187),
                                  child: Text(
                                    " PRAYER ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getlat(context) / 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 185, 213, 187),
                                  child: Text(
                                    " ADHAN ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getlat(context) / 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 185, 213, 187),
                                  child: Text(
                                    " IQAMAH ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getlat(context) / 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ))
                          ])),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 1, 30, 3),
                  width: MediaQuery.of(context).size.width * 0.5 + 50,
                  height: getlat(context) / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: getCorrectColor_Salat('fajr'),
                      child: StreamBuilder(
                          stream: events
                              .where('Date',
                                  isEqualTo: getDategsynch().toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot tit =
                                    snapshot.data!.docs[index];
                                return Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Column(
                                        children: [
                                          Text(
                                            "الفجر",
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'fajr'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Fajr",
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'fajr'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tit['FAJR start'],
                                        style: TextStyle(
                                          color:
                                              getCorrectColor_SalatText('fajr'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        tit['FAJR prayer'],
                                        style: TextStyle(
                                          color:
                                              getCorrectColor_SalatText('fajr'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]));
                              },
                            );
                          })),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 1, 30, 3),
                  width: MediaQuery.of(context).size.width * 0.5 + 50,
                  height: getlat(context) / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getCorrectColor_Salat('dhuhr'),
                  ),
                  child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      child: StreamBuilder(
                          stream: events
                              .where('Date',
                                  isEqualTo: getDategsynch().toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot tit =
                                    snapshot.data!.docs[index];
                                return Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Column(children: [
                                        Text(
                                          "الظهر",
                                          style: TextStyle(
                                            color: getCorrectColor_SalatText(
                                                'dhuhr'),
                                            fontSize: getlat(context) / 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Dhuhr",
                                          style: TextStyle(
                                            color: getCorrectColor_SalatText(
                                                'dhuhr'),
                                            fontSize: getlat(context) / 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                      Text(
                                        tit['DHUHR start'],
                                        style: TextStyle(
                                          color: getCorrectColor_SalatText(
                                              'dhuhr'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        tit['DHUHR prayer'],
                                        style: TextStyle(
                                          color: getCorrectColor_SalatText(
                                              'dhuhr'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]));
                              },
                            );
                          })),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 1, 30, 3),
                  width: MediaQuery.of(context).size.width * 0.5 + 50,
                  height: getlat(context) / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: getCorrectColor_Salat('asr'),
                      child: StreamBuilder(
                          stream: events
                              .where('Date',
                                  isEqualTo: getDategsynch().toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot tit =
                                    snapshot.data!.docs[index];
                                return Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Column(
                                        children: [
                                          Text(
                                            "العصر",
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'asr'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Asr",
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'asr'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tit['ASR start'],
                                        style: TextStyle(
                                          color:
                                              getCorrectColor_SalatText('asr'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        tit['ASR prayer'],
                                        style: TextStyle(
                                          color:
                                              getCorrectColor_SalatText('asr'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]));
                              },
                            );
                          })),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 1, 30, 3),
                  width: MediaQuery.of(context).size.width * 0.5 + 50,
                  height: getlat(context) / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: getCorrectColor_Salat('maghrib'),
                      child: StreamBuilder(
                          stream: events
                              .where('Date',
                                  isEqualTo: getDategsynch().toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot tit =
                                    snapshot.data!.docs[index];
                                return Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Column(
                                        children: [
                                          Text(
                                            "المغرب",
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'maghrib'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Maghrib',
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'maghrib'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tit['MAGHRIB start'],
                                        style: TextStyle(
                                          color: getCorrectColor_SalatText(
                                              'maghrib'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        tit['MAGHRIB prayer'],
                                        style: TextStyle(
                                          color: getCorrectColor_SalatText(
                                              'maghrib'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]));
                              },
                            );
                          })),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 1, 30, 3),
                  width: MediaQuery.of(context).size.width * 0.5 + 50,
                  height: getlat(context) / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: getCorrectColor_Salat('isha'),
                      child: StreamBuilder(
                          stream: events
                              .where('Date',
                                  isEqualTo: getDategsynch().toString())
                              .snapshots(),
                          builder: (context, snapshot) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot tit =
                                    snapshot.data!.docs[index];
                                return Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                      Column(
                                        children: [
                                          Text(
                                            "العشاء",
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'isha'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Isha",
                                            style: TextStyle(
                                              color: getCorrectColor_SalatText(
                                                  'isha'),
                                              fontSize: getlat(context) / 35,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        tit['ISHA start'],
                                        style: TextStyle(
                                          color:
                                              getCorrectColor_SalatText('isha'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        tit['ISHA prayer'],
                                        style: TextStyle(
                                          color:
                                              getCorrectColor_SalatText('isha'),
                                          fontSize: getlat(context) / 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]));
                              },
                            );
                          })),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 172, 207, 173),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "الجمعة",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Jummuah",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "13:30",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            )),
                        Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 172, 207, 173),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "الزوال",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Zawal",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${prayerTimes.dhuhr!.hour}:${prayerTimes.dhuhr!.minute}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            )),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Material(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 172, 207, 173),
                              child: StreamBuilder(
                                  stream: events
                                      .where('Date',
                                          isEqualTo: getDategsynch().toString())
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot tit =
                                            snapshot.data!.docs[index];
                                        return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                " الشروق ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Sunrise",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                tit['SUN RISE'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]);
                                      },
                                    );
                                  })),
                        ),
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Color getCorrectColor_Salat(salat) {
  DateTime date = (DateTime.now());
  Coordinates coordinates =
      Coordinates(53.506516477842055, -2.2445736729918266);
  CalculationParameters params = CalculationMethod.UmmAlQura();
  params.madhab = Madhab.Shafi;
  List prayers = ['fajr', 'dhuhr', 'asr', 'maghrib', 'isha'];
  var prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
  if (prayerTimes.nextPrayer(date: date) == salat) {
    return Color.fromARGB(255, 17, 89, 50);
  }
  ;
  //if (prayerTimes.nextPrayer(date: date) == salat) {
  //  return Color.fromARGB(255, 160, 207, 162);
  //}
  //;

  return Colors.transparent;
}

Color getCorrectColor_SalatText(salat) {
  DateTime date = (DateTime.now());
  Coordinates coordinates =
      Coordinates(53.506516477842055, -2.2445736729918266);
  CalculationParameters params = CalculationMethod.UmmAlQura();
  params.madhab = Madhab.Shafi;
  List prayers = ['fajr', 'dhuhr', 'asr', 'maghrib', 'isha'];
  var prayerTimes = PrayerTimes(coordinates, date, params, precision: true);
  if (prayerTimes.nextPrayer(date: date) == salat) {
    return Color.fromARGB(255, 255, 255, 255);
  }
  ;
  //if (prayerTimes.nextPrayer(date: date) == salat) {
  //  return Color.fromARGB(255, 160, 207, 162);
  //}
  //;

  return Colors.black;
}

getDategsynch() {
  List mounths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final jh1 = DateTime.now().toString().substring(0, 10);
  String ss = jh1.toString();
  int oc = ss.indexOf("-");
  String sss = ss.substring(oc + 1, ss.length - 1);
  int oc2 = ss.length - 3;
  int mm = int.parse(ss.substring(oc + 1, oc2));
  String mounth = mounths[mm - 1];
  String date = ss.substring(ss.length - 2, ss.length) + '-' + mounth;
  return date;
}

getDateserv() {
  List mounths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final jh1 = DateTime.now().toString().substring(0, 10);
  String ss = jh1.toString();
  int oc = ss.indexOf("-");
  String sss = ss.substring(oc + 1, ss.length - 1);
  int oc2 = ss.length - 3;
  int mm = int.parse(ss.substring(oc + 1, oc2));
  String mounth = mounths[mm - 1];
  String date = ss.substring(ss.length - 2, ss.length) + '-' + mounth;
  print(date);
  return '02-Jun';
}

getDate() {
  List mounths = [
    'Muḥarram',
    'Ṣafar',
    'Rabīʿ al-Awwal',
    'Rabīʿ al-Thānī',
    'Jumādā al-Awwal',
    'Jumādā al-Thānī',
    'Rajab',
    'Shaʿbān',
    'Ramaḍān',
    'Shawwāl',
    'Dhū al-Qaʿdah',
    'Dhū al-Ḥijjah'
  ];
  final jh1 = JHijri.now();
  String ss = jh1.toString();
  int oc = ss.indexOf("-");
  String sss = ss.substring(oc + 1, ss.length - 1);
  int oc2 = ss.length - 5;
  int mm = int.parse(ss.substring(oc + 1, oc2));
  String mounth = mounths[mm - 1];
  String date = mounth +
      ' ' +
      ss.substring(0, oc) +
      ', ' +
      ss.substring(ss.length - 4, ss.length);
  return date;
}

getDateg() {
  List mounths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final jh1 = DateTime.now().toString().substring(0, 10);
  String ss = jh1.toString();
  int oc = ss.indexOf("-");
  String sss = ss.substring(oc + 1, ss.length - 1);
  int oc2 = ss.length - 3;
  int mm = int.parse(ss.substring(oc + 1, oc2));
  String mounth = mounths[mm - 1];
  String date = ss.substring(ss.length - 2, ss.length) +
      ' ' +
      mounth +
      ' ' +
      ss.substring(0, oc);
  return date;
}

minutes() {
  if (DateTime.now().minute.toString().length == 1) {
    return '0' + DateTime.now().minute.toString();
  }
  return DateTime.now().minute.toString();
}
