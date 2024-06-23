import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class firebaseMSG {
  CollectionReference events = FirebaseFirestore.instance.collection('tk');

  final _firebaseMSG = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMSG.requestPermission();
    final Token = await _firebaseMSG.getToken();
    events.add({
      'token': Token,
    });

    print('token${Token}');
  }
}
