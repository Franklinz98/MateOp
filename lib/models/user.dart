import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MOUser {
  User firebaseUser;
  int age, schoolType, gender, grade, session, stars;
  String course;
  bool performanceJson;
  double score, winRate;
  List registries;

  MOUser(
      {@required this.age,
      @required this.schoolType,
      @required this.gender,
      @required this.grade,
      @required this.performanceJson,
      this.firebaseUser,
      this.session,
      this.score,
      this.winRate,
      this.stars});

  void updateWinRate(double rate) {
    winRate = (winRate * (session / (session + 1))) + (rate / (session + 1));
  }

  void updateScore(double newScore) {
    score = score + (newScore / (session + 1));
  }

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
        'hasPerformanceData': performanceJson,
        'score': score,
        'winRate': winRate,
        'session': session,
        'stars': stars,
      };

  Map<String, dynamic> get updateJson => {
        'score': score,
        'winRate': winRate,
        'hasPerformanceData': performanceJson,
        'session': session,
        'stars': stars,
        'record': registries
      };

  factory MOUser.fromJson(Map<String, dynamic> map) {
    return MOUser(
      age: map['age'],
      schoolType: map['schoolType'],
      gender: map['gender'],
      grade: map['grade'],
      performanceJson: map['hasPerformanceData'],
      session: map['session'],
      score: map['score'].toDouble(),
      winRate: map['winRate'].toDouble(),
      stars: map['stars'],
    );
  }
}
