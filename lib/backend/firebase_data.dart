import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mate_op/models/user.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Fetch performance data saved on database
Future<Map> getPerformanceData(MOUser user) async {
  try {
    DocumentSnapshot documentSnapshot = await firestore
        .collection('data')
        .doc('performance')
        .collection(user.firebaseData.uid)
        .doc('session${user.session}')
        .get();
    return documentSnapshot.data();
  } on Exception catch (e) {
    throw Exception('cant do it: ${e.toString()}');
  }
}

// Post performance data
Future<void> updatePerformanceData(
    MOUser user, Map performanceVectorsData) async {
  await firestore
      .collection('data')
      .doc('performance')
      .collection(user.firebaseData.uid)
      .doc('session${user.session}')
      .set(performanceVectorsData);
}
