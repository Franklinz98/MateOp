import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/models/user.dart';
import 'package:path/path.dart' as p;

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
Future<Map> getPerformanceData(MOUser user, OperationType operation) async {
  try {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('data')
        .doc('performance')
        .collection(user.firebaseUser.uid)
        .doc(
            'session${user.getSession(operation)}_${p.extension(operation.toString()).replaceAll('.', '')}')
        .get();
    return documentSnapshot.data();
  } on Exception catch (e) {
    throw Exception('cant do it: ${e.toString()}');
  }
}

// Post performance data
Future<void> updatePerformanceData(
    MOUser user, OperationType operation, Map performanceVectorsData) async {
  try {
    DocumentReference performanceRef = _firestore
        .collection('data')
        .doc('performance')
        .collection(user.firebaseUser.uid)
        .doc(
            'session${user.getSession(operation)}_${p.extension(operation.toString()).replaceAll('.', '')}');
    performanceRef.set(performanceVectorsData);
  } catch (e) {
    print(e.toString());
  }
}

Future<bool> checkPerformanceData(MOUser user, OperationType operation) async {
  try {
    DocumentSnapshot performanceSnapshot = await _firestore
        .collection('data')
        .doc('performance')
        .collection(user.firebaseUser.uid)
        .doc(
            'session${user.getSession(operation)}_${p.extension(operation.toString()).replaceAll('.', '')}')
        .get();
    return performanceSnapshot.exists;
  } catch (e) {
    return false;
  }
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
  for (var i = 0; i < 15; i++) {
    los.add(map);
  }
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
