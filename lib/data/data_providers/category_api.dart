import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wpam_app/services/firestore_users.dart';

class CategoryAPI {
  Future<dynamic> featchRawCategories() async {
    return FirebaseFirestore.instance
        .collection('categories')
        .doc(userId)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
  }
}
