import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MOUser {
  User firebaseUser;
  int age, schoolType, gender, grade, session;
  bool hasPerformanceData;

  MOUser(
      {@required this.age,
      @required this.schoolType,
      @required this.gender,
      @required this.grade,
      @required this.hasPerformanceData,
      this.firebaseUser,
      this.session});

  Map<String, dynamic> toJsonPrediction() => {
        'edad': age,
        'tipoEscuela': schoolType,
        'genero': gender,
        'grado': grade,
      };

  Map<String, dynamic> toJson() => {
        'age': age,
        'schoolType': schoolType,
        'gender': gender,
        'grade': grade,
        'session': session
      };

  factory MOUser.fromJson(Map<String, dynamic> map) {
    return MOUser(
        age: map['age'],
        schoolType: map['schoolType'],
        gender: map['gender'],
        grade: map['grade'],
        hasPerformanceData: map['hasPerformanceData'],
        session: map['session']);
  }
}
