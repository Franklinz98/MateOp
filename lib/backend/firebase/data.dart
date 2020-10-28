import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mate_op/models/user.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<Map> getUserMetadata(String uid) async {
  try {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('students').doc(uid).get();
    return userSnapshot.data();
  } catch (e) {
    throw Exception('Error: ${e.toString()}');
  }
}

Future<bool> updateUserMetadata(MOUser user) async {
  try {
    DocumentReference userData =
        _firestore.collection('students').doc(user.firebaseUser.uid);
    await userData.update(user.updateJson);
    return true;
  } catch (e) {
    throw Exception(e.toString());
  }
}

// Fetch performance data saved on database
Future<Map> getPerformanceData(MOUser user) async {
  try {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('data')
        .doc('performance')
        .collection(user.firebaseUser.uid)
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
  await _firestore
      .collection('data')
      .doc('performance')
      .collection(user.firebaseUser.uid)
      .doc('session${user.session}')
      .set(performanceVectorsData);
}

Future<bool> setTimes() {
  Map map = {
    '1': 0,
    '2': 0,
    '3': 0,
    '4': 0,
    '5': 0,
  };
  List<Map> los = [];
  los.add(map);
  los.add(map);
  los.add(map);
  los.add(map);
  los.add(map);
  _firestore
      .collection('time_data')
      .doc('0')
      .set({'data': los, 'metadata': los});
  _firestore
      .collection('time_data')
      .doc('1')
      .set({'data': los, 'metadata': los});
}

Future<Map> getAverageTimes(int schoolType) async {
  try {
    DocumentSnapshot timesData = await _firestore
        .collection('time_data')
        .doc(schoolType.toString())
        .get();
    return timesData.data();
  } catch (e) {
    return null;
  }
}

Future<void> setAverageTimes(Map map, int schoolType) async {
  try {
    _firestore.collection('time_data').doc(schoolType.toString()).set(map);
  } catch (e) {
    print('error');
  }
}
