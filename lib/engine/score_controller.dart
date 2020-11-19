import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/backend/local/data.dart';
import 'package:mate_op/models/exercise_manager.dart';
import 'package:mate_op/models/performance_vectors.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';

void updateFileWithVectorPerformace(MateOpState state) {
  ExerciseManager exerciseManager = state.exerciseManager;
  MOUser user = state.user;
  PerformanceVectors performanceVectors =
      PerformanceVectors.readObjectFromFile(state.localPath);
  performanceVectors.updatePerformanceVectorsSet(
      exerciseManager.allExercises, user.grade, user.session);
  performanceVectors.writeObjectInFile(state.localPath);
  try {
    print(performanceVectors.toJson().runtimeType);
    updatePerformanceData(user, performanceVectors.toFirebaseJson());
    // clearSessionFile(user);
    deleteSessionFile(state.localPath, state.userId);
    updateAverageTimes(exerciseManager, user);
    List results = exerciseManager.getResults();
    user.updateWinRate(results[3]);
    user.score += results[4];
    user.stars += results[2];
    user.performanceJson = true;
    user.registries = performanceVectors.userRecord();
    updateUserMetadata(user);
  } catch (e) {
    print(e.toString());
  }
}

void updateAverageTimes(ExerciseManager exerciseManager, MOUser user) async {
  Map times = await getAverageTimes(user.schoolType);
  String grade = user.grade.toString();
  for (var i = 0; i < 5; i++) {
    int number = times['metadata'][i][grade];
    double time = times['data'][i][grade].toDouble();
    double uTime = exerciseManager.getAverageTimePerLO(i);
    if (!uTime.isNaN) {
      time = (time * (number / (number + 1))) + (uTime / (number + 1));
      times['metadata'][i][grade] = number + 1;
      times['data'][i][grade] = time;
    }
  }
  await setAverageTimes(times, user.schoolType);
}
