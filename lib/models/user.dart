import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mate_op/constants/enums.dart';

class MOUser {
  User firebaseUser;
  int age, schoolType, gender, grade, stars, sessionAdd, sessionSubs;
  String course, token;
  double score, winRate;
  List registries;

  MOUser(
      {@required this.age,
      @required this.schoolType,
      @required this.gender,
      @required this.grade,
      this.sessionAdd,
      this.sessionSubs,
      this.firebaseUser,
      this.score,
      this.winRate,
      this.stars,
      this.token});

  void updateWinRate(double rate) {
    int session = sessionAdd == -1 ? 0 : sessionAdd;
    session += sessionSubs == -1 ? 0 : sessionSubs;
    if (session == 0 && sessionAdd == sessionSubs) {
      session++;
    }
    winRate = (winRate * (session / (session + 1))) + (rate / (session + 1));
  }

  void updateScore(double newScore) {
    score += newScore;
  }

  void increaseSession(OperationType operation) {
    if (operation == OperationType.addition) {
      sessionAdd++;
    } else if (operation == OperationType.subtraction) {
      sessionSubs++;
    }
  }

  int getSession(OperationType operation) {
    if (operation == OperationType.addition) {
      return sessionAdd;
    } else if (operation == OperationType.subtraction) {
      return sessionSubs;
    } else {
      return sessionAdd + sessionSubs;
    }
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
        'sessionAdd': sessionAdd,
        'sessionSubs': sessionSubs,
        'score': score,
        'winRate': winRate,
        'stars': stars,
      };

  Map<String, dynamic> get updateJson => {
        'score': score,
        'winRate': winRate,
        'sessionAdd': sessionAdd,
        'sessionSubs': sessionSubs,
        'stars': stars,
        'record': registries
      };

  factory MOUser.fromJson(Map<String, dynamic> map) {
    return MOUser(
      age: map['age'],
      schoolType: map['schoolType'],
      gender: map['gender'],
      grade: map['grade'],
      sessionAdd: map['sessionAdd'],
      sessionSubs: map['sessionSubs'],
      score: map['score'].toDouble(),
      winRate: map['winRate'].toDouble(),
      stars: map['stars'],
    );
  }
}
