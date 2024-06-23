import 'package:cloud_firestore/cloud_firestore.dart';

class DatabasemETHOD {
  Future addEventDetails(Map<String, dynamic> eventInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('events')
        .doc(id)
        .set(eventInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEventDetails() async {
    return await FirebaseFirestore.instance.collection("events").snapshots();
  }
}
