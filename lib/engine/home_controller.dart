import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/backend/service/service.dart';
import 'package:mate_op/engine/playground.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/intensities.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';

import 'exercise_generator.dart';

void start(Playground playground, MateOpState state) async {
  ExerciseManager exerciseManager = playground.exerciseManager;
  MOUser user = playground.user;
  /* bool sessionExist = checkSessionFile(user);
  if (sessionExist) { */
  if (getLocalFile(state.localPath, 'session_file_${state.userId}')
      .existsSync()) {
    ExerciseManager session = readSessionFile(state.localPath, state.userId);
    playground.exerciseManager = session;
    exerciseManager = session;
    playground.startSession(state);
  } else {
    if (user.performanceJson) {
      Map performanceData = await getPerformanceData(user);
      Intensity intensity = await getNextIntensityLevel(performanceData);
      List exercises = await generateExercisesFromLOPerformance(
          intensity, 15, state.localPath);
      exerciseManager.allExercises = exercises;
      exerciseManager.currentExercise = 0;
      exerciseManager.finalTime = Duration();
      playground.startSession(state);
    } else {
      Intensity intensity = await predictInicitalIntensity(user);
      List exercises = await generateExercisesFromLOPerformance(
          intensity, 15, state.localPath);
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
      performanceVectors.writeObjectInFile(state.localPath);
      playground.startSession(state);
    }
  }
}
