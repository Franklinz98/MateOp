import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MOUser {
  User firebaseUser;
  int age, schoolType, gender, grade, session;
  String course;
  Map performanceJson;
  double score, winRate;

  MOUser(
      {@required this.age,
      @required this.schoolType,
      @required this.gender,
      @required this.grade,
      @required this.performanceJson,
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
        'performance': performanceJson,
        'score': score,
        'winRate': winRate,
        'session': session
      };

  Map<String, dynamic> get updateJson => {
        'score': score,
        'winRate': winRate,
        'performance': performanceJson,
        'session': session
      };

  factory MOUser.fromJson(Map<String, dynamic> map) {
    return MOUser(
        age: map['age'],
        schoolType: map['schoolType'],
        gender: map['gender'],
        grade: map['grade'],
        performanceJson: map['performance'],
        session: map['session']);
  }
}
