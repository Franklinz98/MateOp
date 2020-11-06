import 'dart:convert';
import 'dart:io';

import 'exercise.dart';

class ExerciseManager {
  List allExercises;
  int currentExercise;
  Duration finalTime;

  ExerciseManager({this.allExercises, this.currentExercise, this.finalTime});

  void answerCurrentExercise(double ans) {
    getCurrentExercise().playerAnswer = ans;
  }

  void nextExercise() {
    if (currentExercise < allExercises.length) {
      currentExercise++;
    }
  }

  bool isTestFinished() {
    return currentExercise == allExercises.length;
  }

  Exercise getCurrentExercise() {
    return allExercises[currentExercise];
  }

  int _getGoodAnswers() {
    int number;
    number = 0;
    allExercises.forEach((exercise) {
      if (exercise.checkAnswer()) {
        number++;
      }
    });
    return number;
  }

  List getResults() {
    int goodAnswers = _getGoodAnswers();
    int totalAnswers = allExercises.length;
    int stars = goodAnswers ~/ 5;
    double winRatio = goodAnswers / totalAnswers;
    winRatio = (winRatio * 100).roundToDouble() / 100;
    return [
      goodAnswers,
      totalAnswers,
      stars,
      winRatio,
      _getSessionScore(),
      finalTime
    ];
  }

  Map<String, dynamic> toJson() {
    List exercises = List();
    allExercises.forEach((exercise) {
      exercises.add(exercise.toJson());
    });
    return {
      'currentExercise': currentExercise,
      'finalTime': finalTime.inMilliseconds,
      'allExercises': json.encode(exercises),
    };
  }

  factory ExerciseManager.fromJson(Map<String, dynamic> map) {
    List exercisesJson = json.decode(map['allExercises']);
    List exercises = List();
    exercisesJson.forEach((exerciseJson) {
      exercises.add(Exercise.fromJson(exerciseJson));
    });
    return ExerciseManager(
      allExercises: exercises,
      currentExercise: map['currentExercise'],
      finalTime: Duration(milliseconds: map['finalTime']),
    );
  }
  int _getSessionScore() {
    double score = 0;
    allExercises.forEach((exercise) {
      double exScore = exerciseScore(exercise);
      score += exScore;
    });
    score *= 150;
    return score.round();
  }

  double exerciseScore(Exercise exercise) {
    if (exercise.checkAnswer()) {
      double time = (1 / exercise.duration.inSeconds) * 0.4;
      if (exercise.hesitations == -1) {
        print('object');
      }
      int exHesitation = exercise.hesitations == -1 ? 0 : exercise.hesitations;
      double hesitation = (1 / (exHesitation + 1)) * 0.6;
      return time + hesitation;
    } else {
      return 0;
    }
  }

  double getAverageTimePerLO(int lo) {
    double av = 0;
    int cont = 0;
    allExercises.forEach((exercise) {
      if (exercise.loID == lo) {
        av += exercise.duration.inSeconds.toDouble();
        cont++;
      }
    });
    return av / cont;
  }
}
