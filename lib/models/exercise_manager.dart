import 'dart:convert';

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
    return currentExercise == allExercises.length-1;
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
      double exScore = _exerciseScore(exercise);
      score += exScore;
    });
    score *= 100;
    return score.round();
  }

  double _exerciseScore(Exercise exercise) {
    if (exercise.checkAnswer()) {
      double time = exercise.duration.inSeconds.toDouble();
      if (exercise.dificulty == 0) {
        time = time > 7 ? 7 / time : 1;
      } else {
        time = time > 15 ? 15 / time : 1;
      }
      time = time * 0.5;
      int exHesitation = exercise.hesitations == -1 ? 0 : exercise.hesitations;
      double hesitation = (1 / (exHesitation + 1)) * 0.5;
      return time + hesitation;
    } else {
      return 0;
    }
  }

  double getAverageTimePerLO(int lo) {
    double av = 0;
    int cont = 0;
    allExercises.forEach((exercise) {
      if (exercise.learningObj == lo) {
        av += exercise.duration.inSeconds.toDouble();
        cont++;
      }
    });
    return av / cont;
  }
}
