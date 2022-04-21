import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wpam_app/services/firestore_users.dart';

class TrackerAPI {
  Future<dynamic> featchRawTrackingItems() async {
    return FirebaseFirestore.instance
        .collection('tracking')
        .doc(userId)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
  }

  Future<void> saveTrackingItems(Map<String, Object?> data) async {
    return FirebaseFirestore.instance
        .collection('tracking')
        .doc(userId)
        .update(data);
  }
}
