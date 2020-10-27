import 'dart:io';
import 'dart:convert';

import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/backend/service/service.dart';
import 'package:mate_op/engine/playground.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/intensities.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/models/user.dart';

import 'exercise_generator.dart';

void start(Playground playground) async {
  ExerciseManager exerciseManager = playground.exerciseManager;
  MOUser user = playground.user;
  String path = await localPath;
  File sessionFile = getLocalFile("$path/addition", "uid");
  if (sessionFile.existsSync()) {
    String fileContent = await sessionFile.readAsString();
    Map jsonObject = json.decode(fileContent);
    ExerciseManager session = await readSessionFile(user);
    exerciseManager.currentExercise = session.currentExercise;
    exerciseManager.allExercises = session.allExercises;
  } else {
    if (user.performanceJson.isNotEmpty) {
      Map performanceData = await getPerformanceData(user);
      Intensity intensity = await getNextIntensityLevel(performanceData);
      List exercises = await generateExercisesFromLOPerformance(intensity, 15);
      exerciseManager.allExercises = exercises;
      exerciseManager.currentExercise = 0;
      exerciseManager.finalTime = Duration();
      await playground.startSession();
    } else {
      Intensity intensity = await predictInicitalIntensity(user);
      List exercises = await generateExercisesFromLOPerformance(intensity, 15);
      exerciseManager.allExercises = exercises;
      exerciseManager.currentExercise = 0;
      exerciseManager.finalTime = Duration();
      PerformanceVectors performanceVectors = PerformanceVectors();
      // performanceVectors.jsonIntensities =
      performanceVectors.grado = user.grade;
      performanceVectors.sesion = user.session;
      performanceVectors.tipoEscuela = user.schoolType;
      performanceVectors.setBinperPerformanceVectors([
        [1, 0],
        [1, 0],
        [1, 0],
        [1, 0],
        [1, 0]
      ]);
      performanceVectors.writeObjectInFile(await localPath);
      await playground.startSession();
    }
  }
}
