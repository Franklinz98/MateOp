import 'dart:io';
import 'dart:convert';
import 'package:mate_op/backend/data.dart';
import 'package:mate_op/backend/firebase_data.dart';
import 'package:mate_op/backend/service.dart';
import 'package:mate_op/engine/exercise_generator.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/session_file.dart';
import 'package:mate_op/models/user.dart';

void start() async {
  MOUser user;
  ExerciseManager exerciseManager =
      ExerciseManager(); //Exercisemanager of provider
  String path = await localPath;
  File sessionFile = getLocalFile("$path/addition", "uid");
  if (sessionFile.existsSync()) {
    String fileContent = await sessionFile.readAsString();
    Map jsonObject = json.decode(fileContent);
    SessionFile session = SessionFile.fromJson(jsonObject);
    exerciseManager.currentExercise = session.index;
    exerciseManager.allExercises = session.exercises;
  } else {
    if (user.hasPerformanceData) {
      getPerformanceData(user)
          .then((performanceData) => getNextIntensityLevel(performanceData)
              .then((intensity) =>
                  generateExercisesFromLOPerformance(intensity, 15)
                      .then((exercises) {
                    exerciseManager.allExercises = exercises;
                    // TODO write performance to file
                    // TODO GoTo playground
                  }))
              .catchError((error) {}))
          .catchError((error) {});
    } else {
      predictInicitalIntensity(user)
          .then((intensity) => generateExercisesFromLOPerformance(intensity, 15)
                  .then((exercises) {
                exerciseManager.allExercises = exercises;
                // TODO write performance to file
                // TODO GoTo playground
              }))
          .catchError((error) {});
    }
  }
}
